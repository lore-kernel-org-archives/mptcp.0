Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF429D6
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 01:07:20 +0000 (UTC)
IronPort-SDR: US9LUCGshCUqJO0ZckEaBfhYbs0iAkq/qpMBoHHBzVanXwslFuAIxKBTeCdJQm18/OgOKmvcry
 Db+Z4+UIFfdg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="187450642"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="187450642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 18:07:20 -0700
IronPort-SDR: q8OcPytro/wnUux0QOo5UzE/macMCW0fZgEHuVGmi8c4x07tlURpwY1qLnwfL4si23Lw3PDD/d
 Y2xBa9yJL7qA==
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="557855659"
Received: from vsampat1-mobl2.amr.corp.intel.com ([10.212.210.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 18:07:19 -0700
Date: Fri, 25 Jun 2021 18:07:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jianguo Wu <wujianguo106@163.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev, 
    pabeni@redhat.com, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
In-Reply-To: <e8085dfd-9151-049e-cc1e-3267236a1b2d@163.com>
Message-ID: <ad48992-c04c-baa6-e469-988c559f3cc8@linux.intel.com>
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com> <1624609559-6786-5-git-send-email-wujianguo106@163.com> <a3caa434-2e3a-3370-c3d5-466023923436@tessares.net> <e8085dfd-9151-049e-cc1e-3267236a1b2d@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 25 Jun 2021, Jianguo Wu wrote:

>
>
> On 2021/6/25 17:07, Matthieu Baerts wrote:
>> Hi Jianguo,
>>
>> Thank you for working on that!
>>
>> On 25/06/2021 10:25, wujianguo106@163.com wrote:
>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>
>>> If check_fully_established() causes a subflow reset, it should not
>>> continue to process the packet in tcp_data_queue().
>>> Add a return value to mptcp_incoming_options(), and return 0 if a
>>> subflow has been reset, else return 1.
>>
>> A small detail but it looks strange to me to return +1.
>> Maybe clearer to return -1 in case of error or return a boolean?
>>
>
> Hi Mat and Geliang,
>
> Based on your comments, I will use boolean type as return value, return false if a subflow has been reset.
> Thanks for your review!

Thanks - I think the 'bool' fits better here than -1/0.

-Mat


>
>> If you decide to return -1, please check for '< 0':
>>
>>   if (mptcp_incoming_options(...) < 0) // error: we discard
>>       goto discard;
>>
>> and not:
>>
>>   if (mptcp_incoming_options(...)) // no error but we discard??
>>       goto discard;
>>
>> (Or replace subflow_is_rst by subflow_is_accepted and return this
>> variable but it might be strange to return that if you don't have a DSS,
>> etc.)
>>
>> But if it is only me who find "strange" to return 0/+1, fine not to
>> change but it looks uncommon and maybe a source of misinterpretation :)
>>
>> Cheers,
>> Matt
>>
>
>

--
Mat Martineau
Intel
