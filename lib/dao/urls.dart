//域名
//const BASE_HOST = 'http://192.168.0.105:7070';
// const BASE_HOST = 'http://10.53.5.5:7070';
const BASE_HOST = 'https://aebox.io';
//const BASE_HOST = 'http://localhost:7070';
//const BASE_HOST = 'https://aeasy.io';

//获取区块高度
const BLOCK_TOP = BASE_HOST + '/api/ae/block_top';

//获取拍卖中的域名
const NAME_AUCTIONS = BASE_HOST + '/api/names/auctions';

//获取拍卖中的域名-价格
const NAME_PRICE = BASE_HOST + '/api/names/price';

//获取拍即将过期的域名
const NAME_OVER = BASE_HOST + '/api/names/over';

//获取我的注册中域名
const NAME_MY_REGISTER = BASE_HOST + '/api/names/my/register';

//获取我的已注册域名
const NAME_MY_OVER = BASE_HOST + '/api/names/my/over';

//注册域名
const NAME_ADD = BASE_HOST + '/api/names/claim';

//更新域名
const NAME_UPDATE = BASE_HOST + '/api/names/update';

//声明域名
const NAME_PRECLAI = BASE_HOST + '/api/names/preclaim';

//域名详情
const NAME_INFO = BASE_HOST + '/api/names/info';

const SWAP_LIST = BASE_HOST + '/api/contract/swap/record';

const SWAP_MY_LIST = BASE_HOST + '/api/contract/swap/record/my';

//用户详情
const ACCOUNT_INFO = BASE_HOST + '/api/user/info';

//生成账户
const USER_REGISTER = BASE_HOST + '/api/user/register';

//登录账户
const USER_LOGIN = BASE_HOST + '/api/user/login';

//基础数据
const BASE_DATA = BASE_HOST + '/api/base/data';

//基础Name数据
const BASE_NAME_DATA = BASE_HOST + '/api/names/base';

//交易记录
const WALLET_RECORD = BASE_HOST + '/api/wallet/transfer/record';

//交易
const WALLET_TRANSFER = BASE_HOST + '/api/wallet/transfer';

//获取合约余额
const CONTRACT_BALANCE = BASE_HOST + '/api/contract/balance';

//获取合约基本信息
const CONTRACT_INFO = BASE_HOST + '/api/contract/info';

//获取交易记录
const CONTRACT_RECORD = BASE_HOST + '/api/contract/record';

//调用合约
const CONTRACT_CALL = BASE_HOST + '/api/contract/call';

//获取hash
const TH_HASH = BASE_HOST + '/api/ae/th_hash';

//调用合约转账
const CONTRACT_TRANSFER = BASE_HOST + '/api/contract/transfer';

//查看合约结果
const CONTRACT_DECODE = BASE_HOST + '/api/contract/decode';

//排行榜
const CONTRACT_RANKING = BASE_HOST + '/api/contract/ranking';

//广播
const TX_BROADCAST = BASE_HOST + '/api/tx/broadcast';

//版本号
const VERSION = BASE_HOST + '/api/version';

//价格
const PRICE = 'https://api.coingecko.com/api/v3/simple/price';
