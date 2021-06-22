Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FED2FB3
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 23:38:57 +0000 (UTC)
IronPort-SDR: 8q6O8PYrQHWhsiu7wU5ZZcuLIIFE5nY4f7jtY8qwuZACaMj23hW+9e4CP1BjzwV7WkQFEutNs8
 kp8zXC/iH6Tg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="268300639"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="268300639"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:38:56 -0700
IronPort-SDR: yuX3QlshN4AL5i2ARwtE1UfhEIeQsHqG+oUa31ALpXzTJu0Vu/oJ//Ajg8FqFlKo4ukcim5cAj
 iEGdqXT0dj5Q==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="639267407"
Received: from mrsastry-mobl1.amr.corp.intel.com ([10.212.137.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:38:56 -0700
Date: Tue, 22 Jun 2021 16:38:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jianguo Wu <wujianguo106@163.com>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 1/4] mptcp: fix warning in __skb_flow_dissect() when
 do syn cookie for subflow join
In-Reply-To: <ad0ed696-8be4-8d9d-5af5-775d620c74be@163.com>
Message-ID: <43f673ac-3622-561b-a6af-96fd7d49f01a@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com> <1623840570-42004-2-git-send-email-wujianguo106@163.com> <64212e1f-2b62-89dc-b4c5-b0c8bae51962@linux.intel.com> <93307b1f-b402-885e-acd0-b5828a11395b@163.com>
 <ad0ed696-8be4-8d9d-5af5-775d620c74be@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 21 Jun 2021, Jianguo Wu wrote:

>
>
> On 2021/6/21 14:14, Jianguo Wu wrote:
>> Hi Mat,
>>
>> On 2021/6/19 6:40, Mat Martineau wrote:
>>>
>>> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
>>>
>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>
>>>> I got the following warning message while doing the test:
>>>
>>> Hi Jianguo, thanks for your patch set and revisions.
>>>
>>> Could you explain some more about which test produced the following result? Was it one of the self tests?
>>>
>>> If this is triggered by test code that is not upstream yet, it would help to add a selftest that shows if this bug is present or fixed. A packetdrill test is also an option, if that is a better way to reproduce the error.
>>>
>>
>> I tested with wrk(https://github.com/wg/wrk) and webfsd(https://github.com/ourway/webfsd) with the assistance of mptcp-tools(https://github.com/pabeni/mptcp-tools),
>> Server side:
>>     ./use_mptcp.sh webfsd -4 -R /tmp/ -p 8099
>> Client side:
>>     ./use_mptcp.sh wrk -c 200 -d 30 -t 4 http://192.168.174.129:8099/
>>
>> I will try self tests.
>>
>
> Hi Mat,
>
> It can not be reproduced with selftests(./mptcp_join.sh -k), because skb->l4_hash is 1 in this scenario,
> and direct using skb->hash, so __skb_flow_dissect() isn't called.
>

Thanks for the information! We hadn't seen the failures with the self 
tests so it's good to know that wrk and webfsd were useful for stress 
testing.

--
Mat Martineau
Intel
