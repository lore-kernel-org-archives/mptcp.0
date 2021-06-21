Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321A71
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 07:22:22 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:52724.806755
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-7fa2b9f747a2447eab643ed0466099a7 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id F08872800AD;
	Mon, 21 Jun 2021 15:15:55 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 7fa2b9f747a2447eab643ed0466099a7 for qitiepeng@chinatelecom.cn;
	Mon Jun 21 15:15:59 2021
X-Transaction-ID: 7fa2b9f747a2447eab643ed0466099a7
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v4 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau
 <mathew.j.martineau@linux.intel.com>, qitiepeng@chinatelecom.cn
References: <1624004309-54480-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624004309-54480-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwsSmzxw5c-pPJNYndQ99FKmFXSuKD6kxpQgwJGe9Q2kpQ@mail.gmail.com>
 <85720e69-d6d4-4a9b-9f1c-0898a1cf5009@chinatelecom.cn>
 <CA+WQbwt0adACAC0HB_KteK8MtHbNjwV2GPfkn1s_DsWJL1pgqQ@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <aeccceca-b3e4-004f-2f7d-1ff221583141@chinatelecom.cn>
Date: Mon, 21 Jun 2021 15:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwt0adACAC0HB_KteK8MtHbNjwV2GPfkn1s_DsWJL1pgqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/6/21 14:42, Geliang Tang wrote:
> Hi Yonglong,
> 
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月21日周一 上午11:52写道：
>>
>>
>> On 2021/6/18 19:20, Geliang Tang wrote:
>>> Hi Yonglong,
>>>
>>> Thanks for v4!
>>>
>>> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月18日周五 下午4:19写道：
>>>> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
>>>> ADD_ADDR/echo-ADD_ADDR option
>>>>
>>>> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>>>>
>>>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>>>> ---
>>>>  net/mptcp/options.c  | 124 +++++++++++++++++++++++++++++++--------------------
>>>>  net/mptcp/pm.c       |  30 ++++---------
>>>>  net/mptcp/protocol.h |  13 +++---
>>>>  3 files changed, 92 insertions(+), 75 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>> index 1aec016..43e3241 100644
>>>> --- a/net/mptcp/options.c
>>>> +++ b/net/mptcp/options.c
>>>> @@ -655,41 +655,64 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>>>         bool drop_other_suboptions = false;
>>>>         unsigned int opt_size = *size;
>>>> -       bool echo;
>>>> -       bool port;
>>>> +       struct mptcp_addr_info remote;
>>>> +       struct mptcp_addr_info local;
>>>> +       u8 add_addr, flags = 0xff;
>>>>         int len;
>>>>
>>>> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
>>>> -            mptcp_pm_should_add_signal_port(msk) ||
>>>> -            mptcp_pm_should_add_signal_echo(msk)) &&
>>>> -           skb && skb_is_tcp_pure_ack(skb)) {
>>>> -               pr_debug("drop other suboptions");
>>>> -               opts->suboptions = 0;
>>>> -               opts->ext_copy.use_ack = 0;
>>>> -               opts->ext_copy.use_map = 0;
>>>> -               remaining += opt_size;
>>>> -               drop_other_suboptions = true;
>>>> -       }
>>>> -
>>>> -       if (!mptcp_pm_should_add_signal(msk) ||
>>>> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
>>>> -               return false;
>>>> -
>>>> -       len = mptcp_add_addr_len(opts->addr.family, echo, port);
>>>> -       if (remaining < len)
>>>> +       if (!mptcp_pm_should_add_signal(msk))
>>>>                 return false;
>>>>
>>>> -       *size = len;
>>>> -       if (drop_other_suboptions)
>>>> -               *size -= opt_size;
>>>> -       opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>>>> -       if (!echo) {
>>>> +       *size = 0;
>>>> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
>>>> +       if (mptcp_pm_should_add_signal_echo(msk)) {
>>>> +               if (skb && skb_is_tcp_pure_ack(skb)) {
>>> '''
>>>> +                       pr_debug("drop other suboptions");
>>>> +                       opts->suboptions = 0;
>>>> +                       opts->ext_copy.use_ack = 0;
>>>> +                       opts->ext_copy.use_map = 0;
>>>> +                       remaining += opt_size;
>>>> +                       drop_other_suboptions = true;
>>> '''
>>>
>>>> +               }
>>>> +               len = mptcp_add_addr_len(remote.family, true, !!remote.port);
>>>> +               if (remaining < len)
>>>> +                       return false;
>>>> +               remaining -= len;
>>>> +               *size += len;
>>>> +               opts->remote = remote;
>>>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
>>>> +               opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
>>>> +               pr_debug("addr_id=%d, echo=1, port=%d addr_signal:%x",
>>>> +                        opts->remote.id, ntohs(opts->remote.port), add_addr);
>>>> +       } else if (mptcp_pm_should_add_signal_addr(msk)) {
>>>> +               if ((local.family == AF_INET6 || local.port) && skb &&
>>>> +                   skb_is_tcp_pure_ack(skb)) {
>>> '''
>>>> +                       pr_debug("drop other suboptions");
>>>> +                       opts->suboptions = 0;
>>>> +                       opts->ext_copy.use_ack = 0;
>>>> +                       opts->ext_copy.use_map = 0;
>>>> +                       remaining += opt_size;
>>>> +                       drop_other_suboptions = true;
>>> '''
>>>
>>> I think this "drop other suboptions" trunk here is still duplicated. Can
>>> we just use one "drop other suboptions" trunk only?
>>>
>>> Thanks.
>>> -Geliang
>>>
>> Hi Geliang, Thanks for you replay.
>>
>> The commit "07f8252fe0e3c2b6320eeff18bdc5b7fb8845cb3" Davide said "echo-ed ADD_ADDR
>> carried over pure TCP ACKs, so there is no need to add a DSS element that would fit
>> only ADD_ADDR with IPv4 address.Drop the DSS from echo-ed ADD_ADDR, regardless of the
>> IP version."
>> ADD_ADDR option can add with DSS if the addr is IPv4. So I think it is more clear
>> to decide "drop other suboptions" in two trunk.
> Could we change it like this:
> 
> '''
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index e77b5d532fb8..8b4cb0581a49 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -673,15 +673,20 @@ static bool
> mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 
>         *size = 0;
>         mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> +
> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
> +           (mptcp_pm_should_add_signal_addr(msk) &&
> +           (local.family == AF_INET6 || local.port))) &&
> +           skb && skb_is_tcp_pure_ack(skb)) {
> +               pr_debug("drop other suboptions");
> +               opts->suboptions = 0;
> +               opts->ext_copy.use_ack = 0;
> +               opts->ext_copy.use_map = 0;
> +               remaining += opt_size;
> +               drop_other_suboptions = true;
> +       }
> +
>         if (mptcp_pm_should_add_signal_echo(msk)) {
> -               if (skb && skb_is_tcp_pure_ack(skb)) {
> -                       pr_debug("drop other suboptions");
> -                       opts->suboptions = 0;
> -                       opts->ext_copy.use_ack = 0;
> -                       opts->ext_copy.use_map = 0;
> -                       remaining += opt_size;
> -                       drop_other_suboptions = true;
> -               }
>                 len = mptcp_add_addr_len(remote.family, true, !!remote.port);
>                 if (remaining < len)
>                         return false;
> @@ -693,15 +698,6 @@ static bool
> mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>                 pr_debug("addr_id=%d, echo=1, port=%d addr_signal:%x",
>                          opts->remote.id, ntohs(opts->remote.port), add_addr);
>         } else if (mptcp_pm_should_add_signal_addr(msk)) {
> -               if ((local.family == AF_INET6 || local.port) && skb &&
> -                   skb_is_tcp_pure_ack(skb)) {
> -                       pr_debug("drop other suboptions");
> -                       opts->suboptions = 0;
> -                       opts->ext_copy.use_ack = 0;
> -                       opts->ext_copy.use_map = 0;
> -                       remaining += opt_size;
> -                       drop_other_suboptions = true;
> -               }
>                 len = mptcp_add_addr_len(local.family, false, !!local.port);
>                 if (remaining < len)
>                         return false;
> '''
> WDYT?
Thanks for your advice.

Because MPTCP_ADD_ADDR_ECHO and MPTCP_ADD_ADDR_SIGNAL can be set at the same time. So as your advice we should
change like this(still I think it not clear than before):

        mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
+       if ((mptcp_pm_should_add_signal_echo(msk) ||
+           (!mptcp_pm_should_add_signal_echo(msk) &&
+           mptcp_pm_should_add_signal_addr(msk) &&
+           (local.family == AF_INET6 || local.port))) &&
+           skb && skb_is_tcp_pure_ack(skb)) {
+               pr_debug("drop other suboptions");
+               opts->suboptions = 0;
+               opts->ext_copy.use_ack = 0;
+               opts->ext_copy.use_map = 0;
+               remaining += opt_size;
+               drop_other_suboptions = true;
+       }
+
        if (mptcp_pm_should_add_signal_echo(msk)) {
-               if (skb && skb_is_tcp_pure_ack(skb)) {


>
>>>
>>>> +               }
>>>> +               len = mptcp_add_addr_len(local.family, false, !!local.port);
>>>> +               if (remaining < len)
>>>> +                       return false;
> And here, I think "remaining -= len;" is missing.
> 
> Thanks,
> -Geliang
> 
"remaining" is not being used in the flowing code. So "remaining -=len;" is not necessary. But you remindme that the "remaining -= len;" can be removed in the first trunk.

I will send v5 as your advice.

