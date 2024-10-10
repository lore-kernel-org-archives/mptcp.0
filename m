Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38E1BE239
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555667; cv=none; b=UJsrEJqhjfX63F6LBD4K3IUu7F/EAoWYH/zNhY09ripUfTSHTG5l68lf0dKVA51MYbuVvUb/XIS4VD6CO+OBbfVv3VWODHnq8IZFIe2AtEd53Ifk/JR3thiGOr+a0RWoW5TBEKiMVCxUe4enTaCaVNF/iDngJ7O4hFvZHAFHIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555667; c=relaxed/simple;
	bh=lkwoAcqWzwC3oikK4DbSPR0NW3ttE5q/nRta+tAX5UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e3n/U2hgdYV5duOzduYI+iIKMLrdmzjEwr6QE6bpaDIk2bHqEkEHdZdE1CmctUkiKY5PAJlO8HPgTTo7JB9B+0TSaA2qp+WDAnRTYOMBXvBEvfQvRA/WRUyxbhDuiBgxOMupuNOhLcqBdNkFyYCx9Hr3NsP/qoTQ2Wxq1/tuLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTgCOx54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTgCOx54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560F1C4CEC6;
	Thu, 10 Oct 2024 10:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728555666;
	bh=lkwoAcqWzwC3oikK4DbSPR0NW3ttE5q/nRta+tAX5UM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CTgCOx54tk/PXFVTAq2anW1tVo+s2QUDnyMME1myYQQFIl57/uXrrXD5a6FjRa6/r
	 cq3FzE+v2r4v8/mRw498GV9KpJ/bblrQysCoPFcT3J0gKoQrPwG7FyUxnCs6NCTwPp
	 V+c/TvafwxwAa4QE04dOe57zmexLO+tprGmgw4GP2wEcsEYs92oZuAq2G2UA66pINz
	 TS4h/BcuYkxnqM8drO+JvLdqTcsKtj9xWMx1FvQuTUWwDo5nT02N88kS9ZoeJnsXG+
	 EeeiVl0aVy8v0MsHmitrSp787niMdvljmPwcsJJmD3181+7SwMoeEFJPsdNKU3E7ui
	 q1WtyM8b+8krw==
Message-ID: <0e99895c-2336-40ce-95cf-b9eddf6dbf7f@kernel.org>
Date: Thu, 10 Oct 2024 12:21:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: use "middlebox interference" for
 MP_TCPRST in case map_valid is false
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
References: <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 08/10/2024 19:31, Davide Caratti wrote:
> RFC8684 suggests use of "Middlebox interference (code 0x06)" in case of
> MPJ subflow that carries data at TCP level with no DSS sub-option. This
> is generally the case when mpext is NULL or mpext->use_map is 0: use a
> dedicated value of 'mapping_status' and use it before closing the socket
> in subflow_check_data_avail().

Thank you!

By chance, do you already have a packetdrill test verifying this? (I
guess one similar to the one I recently added, but with a new subflow?)

> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/518#issuecomment-2389156143

(I think what's after # is not needed: if that's OK, I can strip that
when applying the patch)

> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/mptcp/subflow.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 61482f8b425b..77da7a33598a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -960,7 +960,8 @@ enum mapping_status {
>  	MAPPING_EMPTY,
>  	MAPPING_DATA_FIN,
>  	MAPPING_DUMMY,
> -	MAPPING_BAD_CSUM
> +	MAPPING_BAD_CSUM,
> +	MAPPING_NODSS
>  };
>  
>  static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> @@ -1118,7 +1119,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>  		}
>  
>  		if (!subflow->map_valid)
> -			return MAPPING_INVALID;
> +			return MAPPING_NODSS;

This code looks strange when you read it:

  if ("Invalid")
      return "No DSS";

Just to be sure: do we need this new "No DSS" case, because "Invalid" is
used in other conditions? In other words, do all these MAPPING_INVALID
not all point to "middlebox interference" errors?

Or in subflow_check_data_avail(), can we not look at subflow->map_valid?

  subflow->reset_reason = subflow->map_valid ? MPTCP_RST_EMPTCP :
                          MPTCP_RST_EMIDDLEBOX;

(It's just to be sure it is really needed to introduce a new status)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

