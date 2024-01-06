Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7810E6
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 00:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXvI2pWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3030C433C7;
	Sat,  6 Jan 2024 00:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704502500;
	bh=8DFJsojofA3605aqglbMGhQ2OcK83qqpGwiiUnwnWYE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WXvI2pWl3wyL7rn4jzW7ACHxHQHDMlc+WJMmNcb4JKiY0Pc7AvfaaSFHYheBuJQES
	 uX9o+QPwpUjFEaZj4JKqE5Ou42RBppJ3GseUPDpvD4h60SihPFDQVGq+UWQYx8T6st
	 3sULg55yZW3L/6tci216NEROk18gaA729qWldySQQ8ai35w6DjF2shEAVYKiGrRB2B
	 1KdFVxgm6PizsoUoVKz0+djwVAXDNEOHSpcLxIzGKyjLb6DKf96nAr9cEgeFZla09m
	 fukprLSO4Pj1QPGcMBcwzXA0Pjs/9x3/g9KE/7kB/qBwGfr3DcHqOPyH8g4is3MtMS
	 PaUdp133T3AOg==
Date: Fri, 5 Jan 2024 16:55:00 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 04/24] mptcp: check addrs list in
 userspace_pm_get_local_id
In-Reply-To: <c4dbd8a2-3ad3-1104-ef9c-adea4d1d62bd@kernel.org>
Message-ID: <65fc77d3-a59d-01a1-8bf1-a9ca31d91175@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <cabcff63b79e67ee6ea7aca30e6f7bbba38383fe.1703904325.git.geliang.tang@linux.dev> <c4dbd8a2-3ad3-1104-ef9c-adea4d1d62bd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 5 Jan 2024, Mat Martineau wrote:

> On Sat, 30 Dec 2023, Geliang Tang wrote:
>
>> Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
>> better to check whether this address is already in userspace pm local
>> address list. If it's in the list, no need to add a new entry, just
>> return it's address ID and use this address.
>> 
>
> Good idea!
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
>

Matthieu -

To clarify (based on your discussion in 
https://lore.kernel.org/mptcp/c22d8a90-8b52-4518-8e46-d270f9988c7a@kernel.org/#t 
)

this patch is for mptcp-net.

- Mat
