Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57AF71
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 07:51:56 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:60294.1833110338
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-d870c931ef3146bd8931e1d5a23577d1 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 8A47828009A;
	Mon, 21 Jun 2021 15:51:50 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id d870c931ef3146bd8931e1d5a23577d1 for mathew.j.martineau@linux.intel.com;
	Mon Jun 21 15:51:55 2021
X-Transaction-ID: d870c931ef3146bd8931e1d5a23577d1
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v4 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1624004309-54480-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624004309-54480-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwuD5NT4Rz1NVm6Yr75MrJ=oCrTOV2N-e-_dy2YEcPZyYQ@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <2918bab3-73c7-6dc2-f84f-f27a8e4a9cd5@chinatelecom.cn>
Date: Mon, 21 Jun 2021 15:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuD5NT4Rz1NVm6Yr75MrJ=oCrTOV2N-e-_dy2YEcPZyYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 2021/6/21 15:42, Geliang Tang wrote:
>> +               }
>> +               len = mptcp_add_addr_len(local.family, false, !!local.port);
>> +               if (remaining < len)
>> +                       return false;
>> +               *size += len;
>> +               opts->addr = local;
> Could we rename this struct member addr in struct mptcp_out_options to
> local?
> 
>>                 opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>                                                      msk->remote_key,
>>                                                      &opts->addr);
>> +               opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
>> +               pr_debug("addr_id=%d, ahmac=%llu, echo=0, port=%d, addr_signal:%x",
>> +                        opts->addr.id, opts->ahmac, ntohs(opts->addr.port), add_addr);
> Could we merge these two debug logs into one and move it at the the end
> of this function, before 'return true'?
> 
> -Geliang
> 
Thanks for your review.

I will change them in v5 as your advice.
