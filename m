Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4C70
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 01:10:24 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:57506.372365935
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-4482a2c6bc1b441a9a1ceb467f123a89 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 3F3F82800E8;
	Fri, 18 Jun 2021 09:10:24 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 4482a2c6bc1b441a9a1ceb467f123a89 for mptcp@lists.linux.dev;
	Fri Jun 18 09:10:23 2021
X-Transaction-ID: 4482a2c6bc1b441a9a1ceb467f123a89
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v3 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
 <1623921276-97178-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwsweV92fEpK2bMBt5fzdh=aJExtkDaV4xh7hSxS62mzdg@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <894dd718-4125-7fed-6a90-ca5c31150b38@chinatelecom.cn>
Date: Fri, 18 Jun 2021 09:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsweV92fEpK2bMBt5fzdh=aJExtkDaV4xh7hSxS62mzdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thanks for your review. I will simply the code and send v4 patch.

On 2021/6/17 20:37, Geliang Tang wrote:
>>                                                      &opts->addr);
>> +               opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
>> +               pr_debug("addr_id=%d, ahmac=%llu, echo=0, port=%d, addr_signal:%x",
>> +                        opts->addr.id, opts->ahmac, ntohs(opts->addr.port), add_addr);
>>         }
> There are some duplicate codes here between the
> mptcp_pm_should_add_signal_echo(msk) trunk and the
> mptcp_pm_should_add_signal_addr(msk) trunk, could you please simply them
> into one trunk?
> 
