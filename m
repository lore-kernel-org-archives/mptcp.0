Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1110EB
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 23:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D33C433EF;
	Mon, 17 Apr 2023 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681773951;
	bh=vvJa+Q243kL9vbhD5aV9S8AvAMITlhYSzoNgomX0VFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GCNHK8NmkpMyalHXcIj4TrmciulDVmXME4d8TFytX5XmYjoNPb5C5Xhf0Y0IC2gcj
	 sQaO0ItZ/Tgjy+CzJH19U4pAPuKaPXXRXIXJnxIwmnHpRwCI1PfCwQyMTrctaTN03N
	 2ZpGHhwmsd7V4YBjQt7Z/up18qVO/gV1nRkjFnqCceYxjDeY36QaKOwLatAPo7KWn5
	 LGK6jU1hHJjoCws6VNdeIJeQi0hsuidSqsbmRlnwX6F/tqr5VW9wRgmoM8p4HFl7H8
	 3nYZOzfTy2uj63C6pwF0eVV/wIclL4snIKxhuInBxCI7A4iX+IhuFCB0ccHT6yZRCo
	 kh5GhBgQTmmEQ==
Message-ID: <fa956ceb-cdfa-5acf-ed1b-7fbe4a2cdef7@kernel.org>
Date: Mon, 17 Apr 2023 16:25:50 -0700
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
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Mat Martineau <mat@martineau.name>
References: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
From: Mat Martineau <martineau@kernel.org>
In-Reply-To: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/23 10:25 AM, Matthieu Baerts wrote:
> Map Mat's old corporate address to his kernel.org one.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Mat's address is still being used because get_maintainers.pl will look
> at the Git history.
> 
> @Mat: still OK to use your kernel.org one?

Hi Matthieu -

Yes, martineau@kernel.org is what I plan to use going forward. Thanks 
for creating the commit!

Signed-off-by: Mat Martineau <martineau@kernel.org>

> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index e42486317d18..ad1d3c166e64 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -297,6 +297,7 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
>   Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
>   Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
>   Mathieu Othacehe <m.othacehe@gmail.com>
> +Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
>   Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
>   Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
>   Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
> 
> ---
> base-commit: f43ad21ca73772d3a95ceb8f20bbf1caebfd3fb5
> change-id: 20230417-mptcp-mat-alias-2c7cb2190e8b
> 
> Best regards,
