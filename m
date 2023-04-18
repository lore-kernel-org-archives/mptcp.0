Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166ED290B
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 22:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD1DC433EF;
	Tue, 18 Apr 2023 22:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681857236;
	bh=7hw+J0Ii0ekVNFYkblxmqDsdDqfcYdtNgtFltIu46II=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NjgCMMqEOf/Af8u9D/GxxIzanLbA1DGqBGwhhApwBYE6q6Kvcg9qOhZfWC/oIlZTG
	 CHZIQueDS3+3JackQRJW4o9NxXTb8veUzUmwwEHTME2GnXh1L+MDAZns7JmA1Q+saq
	 pHRswLLQbRSRhO4RpBgjLcd6QAoMCjU3CJV4GTM+R+FMFA5bqETc+9jlPqBYh+zEtF
	 P/IpV6YFobmMeurDFqU2eTBJjCYLZFsVpZDpmoIs1GQkUx4OUUrhg2A6yGtlbPDNk/
	 k3ta4No1VeIBP4cJHSdbKsUM6lG+vs9XX7aGaNy/d9HihCekMG13t7EZwiRXg1EJ7v
	 8tFWXfL5ur+sQ==
Message-ID: <1c13227a-c598-0ff3-ac7b-432c7dd03dd3@kernel.org>
Date: Tue, 18 Apr 2023 15:33:56 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next] MAINTAINERS: Resume MPTCP co-maintainer role
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
References: <20230418185730.40775-1-martineau@kernel.org>
 <af85e467-8d0a-4eba-b5f8-e2f2c5d24984@tessares.net>
Content-Language: en-US
From: Mat Martineau <martineau@kernel.org>
In-Reply-To: <af85e467-8d0a-4eba-b5f8-e2f2c5d24984@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/23 1:33 PM, Matthieu Baerts wrote:
> Hi Mat,
> 
> 18 Apr 2023 20:57:41 Mat Martineau <martineau@kernel.org>:
> 
>> I'm returning to the MPTCP maintainer role I held for most of the
>> subsytem's history. This time I'm using my kernel.org email address.
> 
> Welcome back! :-)

Glad to be here!

> 
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Thank you for the patch! Do you want to send it to netdev directly?
Sure, I will go ahead and send it with your tag and a lore link to your message.


- Mat
