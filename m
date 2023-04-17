Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DB10EB
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 23:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A44C433EF;
	Mon, 17 Apr 2023 23:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681775697;
	bh=QBLcmt42uomByGoQu2CBdhoSNOsPfbCMviyVMtd/EmE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TosHB5QwnVuSDs/SMG12mUt+wjnFHPIRwrrjsj0h302HVqxczmB/EKgbFct9Z29sl
	 L785AQMFE2qPkh3kBDY0VwHw2ouPxkW5JFXqOT4xLkmZyBOYdiDYoZ0/wevQ4ZPonZ
	 6Jdxpix3u4NMyGTXfGoQt5lU7eiavJMRf6ZWtYRRyw+r++seFXyK8IlXKN5ELaa/68
	 edLJ3hMycaLqN2e9RHvraF1YFucQru0x884NIP1R2J/5/L7BhFgou5HBoC67GEpzlQ
	 QYFRdY1shDqZ147uJqx9kGITOr01e7X/cCQZZl/nNQHBKUY41MeFbfFsSibb8AqgDE
	 3KExoAJYiOSmg==
Message-ID: <6772d944-fa7d-b840-04e5-c46600c8c8f3@kernel.org>
Date: Mon, 17 Apr 2023 16:54:57 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next] mailmap: add entry for Mat Martineau
Content-Language: en-US
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Mat Martineau <mat@martineau.name>
References: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
 <fa956ceb-cdfa-5acf-ed1b-7fbe4a2cdef7@kernel.org>
In-Reply-To: <fa956ceb-cdfa-5acf-ed1b-7fbe4a2cdef7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/23 4:25 PM, Mat Martineau wrote:
> 
> 
> On 4/17/23 10:25 AM, Matthieu Baerts wrote:
>> Map Mat's old corporate address to his kernel.org one.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> Mat's address is still being used because get_maintainers.pl will look
>> at the Git history.
>>
>> @Mat: still OK to use your kernel.org one?
> 
> Hi Matthieu -
> 
> Yes, martineau@kernel.org is what I plan to use going forward. Thanks for creating the commit!
> 
> Signed-off-by: Mat Martineau <martineau@kernel.org>

Oops, maybe I should have said:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> 
>> ---
>>   .mailmap | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/.mailmap b/.mailmap
>> index e42486317d18..ad1d3c166e64 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -297,6 +297,7 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
>>   Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
>>   Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
>>   Mathieu Othacehe <m.othacehe@gmail.com>
>> +Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>

Oh yeah! Can you also add

Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>

to cover my old Bluetooth commits?

Thanks,
Mat

>>   Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
>>   Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
>>   Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
>>
>> ---
>> base-commit: f43ad21ca73772d3a95ceb8f20bbf1caebfd3fb5
>> change-id: 20230417-mptcp-mat-alias-2c7cb2190e8b
>>
>> Best regards,
> 
