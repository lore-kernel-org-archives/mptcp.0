Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2799B70
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 06:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=3YA1Z
	0Dm95DIb7ZSwpT+Y5+bRAAb8KGH5H6F86BctcM=; b=NwweI+TXUK+hq0XoySE7H
	medvTsP7e8A5TXbz9aXRzAHazJJDaxR5nDMKhhMdF/m/vCzIH7X0YLuoNOc6WSAu
	xEQ3scZ/NdZLL5XrCj54IChDrKxLurxLTq4FD8tQT6AU2hB0Q8xO1NifDd6ebMWk
	xvTAnL4yzoy73bvzh/d2AA=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowADXJbl2a4Jgc5X2HA--.2976S2;
	Fri, 23 Apr 2021 14:38:47 +0800 (CST)
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
Date: Fri, 23 Apr 2021 14:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DcCowADXJbl2a4Jgc5X2HA--.2976S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWxGryUJry3Gr45ur4kWFg_yoW8Ar1fpr
	4fJ3Z8WrW8JFyIgrWvqF42qw1a9as0qrn5GrWj93WIvw4q9F1FqrWUKr13CFy7Crs5tayr
	XF42ga1jvw4Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1a9-UUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiURd9kFWBS6RVCQAAsM



On 2021/4/23 12:33, Geliang Tang wrote:
> Hi Jianguo,
> 
> Thanks for your patch.
> 
> Jianguo Wu <wujianguo106@163.com> 于2021年4月22日周四 下午6:30写道：
>>
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> PM announces address to remote host when signal flag is set,
>> so create listening socket only if signal flag is set.
> 
> This check has done in the user-space, here are these lines in pm_nl_ctl.c:
> 
> 274                 } else if (!strcmp(argv[arg], "port")) {
> 275                         u_int16_t port;
> 276
> 277                         if (++arg >= argc)
> 278                                 error(1, 0, " missing port value");
> 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 280                                 error(1, 0, " flags must be signal
> when using port");
> 

Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add address, It doesn't seem to have done that check.
Is it worth to do check in kernel to make sure there is a signal flag before create listening socket?

> -Geliang
> 
>>
>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>>  net/mptcp/pm_netlink.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index becc32b..dbd6910 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
>>         }
>>
>>         *entry = addr;
>> -       if (entry->addr.port) {
>> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>>                 ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
>>                 if (ret) {
>>                         GENL_SET_ERR_MSG(info, "create listen socket error");
>> --
>> 1.8.3.1
>>
>>

