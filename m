Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BB1C9ECF
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636634; cv=none; b=ZPwnmrV/bI5thTysdsWuEXZw29CLsVgwUPBH7EWacvVqp2qTapOOgoRQheJx3OtBN+rkulxVAK1A38aigCrsuywad2C6G57Jx33A3h3+waG48HSwT3pZWA6VjJBOMFpM+BJAVxYbu5p+s5bcQn2VbEWjFVaeYcClLtIp5jnY5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636634; c=relaxed/simple;
	bh=CRFvbCG7Pt4GMl4b0PUbj2i3F54QDofZU8KwHhYsAd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsbGp2uMD/Vz5c0WAhxgd7fIjJ7qpj2xytIMbnOZa65yVNixQw2V7TNpf1gEZefaOQMvAgHk5xZjACL3QjitZYtYdXN9pQo6A/esP7rV94yKuMxStNmlPIgNfAQ+HT6KnBFdiOY+hKWDBGJqw1zCjB6IXrH0Rb13ZSTpKzgKnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppEYblHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppEYblHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56175C4CEC7;
	Fri,  6 Sep 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725636633;
	bh=CRFvbCG7Pt4GMl4b0PUbj2i3F54QDofZU8KwHhYsAd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ppEYblHjvejYoZs5uWYr2ewZTbhKu8gu59C9CJ9bAZUuEIfhC8S9OE6X7biVIoTUa
	 UFp4km4+aKKCahuHTvEBS+I3tLIxiObk5okAbq2Q9tl4xmbXvfWWKH3z7vl8Qli34s
	 F3MO4/Qrd9RsiaNXPywYGeJfucv31XEnzOYZBgh1f6hsuC0notR5lNI7+BCUCQhXiX
	 CfOtZxO/V8X0Yk2FzpI6zeNuqiOQGhk6ML3Yrq/+WNzvTmtzk9N+/Pxch7f2bPlSDp
	 8vCCAb1GkmtdDuBIuWUWGugWe+00lLpKnh0fwl0FVFe4SZ4dVrQ7Iq9od6U02oDoyN
	 IhtDU1l0VgRFQ==
Message-ID: <023b7d8e-6793-45f8-94b4-51a043d7a114@kernel.org>
Date: Fri, 6 Sep 2024 17:30:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: mptcpd Usersapce PM
Content-Language: en-GB
To: ROSHITH SEBASTIAN <roshith.sebastian@student.unisi.it>
Cc: mptcp@lists.linux.dev
References: <CAOU6Dw9xnP2ha8Csj47_zQQEHg7_FUrgVRW+CrTon-aPLokKog@mail.gmail.com>
 <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org>
 <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
 <8f355da2-5667-412b-b3fd-1ce8f7571fa8@kernel.org>
 <CAOU6Dw-P_RRcVJqf2bGY=d8Vsas+H-9Y0tWLRmyTuFxA+5wsMw@mail.gmail.com>
 <CAOU6Dw8j5hhWeXc9dXYW_BKr7WYC-1_-7HfeP31f8vDYhZ5dmg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAOU6Dw8j5hhWeXc9dXYW_BKr7WYC-1_-7HfeP31f8vDYhZ5dmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 06/09/2024 16:58, ROSHITH SEBASTIAN wrote:
> I have been trying to create a PM using the plugins using the template
> already present in the page as a starting point.
> The following code snippet was inserted into the xxx_new_connection
> and xxx_connection_established functions to identify the remote and
> local addresses being passed to the function:
> 
>     struct sockaddr_in *l_addr = (struct sockaddr_in *)laddr;
>     struct sockaddr_in *r_addr = (struct sockaddr_in *)raddr;
>     char *l_a = inet_ntoa(l_addr->sin_addr);
>     char *r_a = inet_ntoa(r_addr->sin_addr);

I don't think your issue is related to mptcpd: inet_ntoa() is
deprecated, and it is probably causing the issue here. See 'man inet_ntoa':

  The inet_ntoa() function converts the Internet host address in, given
  in network byte order, to a string in IPv4 dotted-decimal notation.
  The string is returned in a statically allocated buffer, which
  **subsequent calls will overwrite**.

(...)

> The function to create a subflow - mptcpd_pm_add_subflow, takes
> mptcpd_aid_t as a parameter. Can you also please let me know where I
> can find the documentation to identify which value has to be used
> here?

You need to provide the local and remote address ID you want to use. 0
correspond to the addresses of the initial subflow. Apart from this
special local address, you are free to use any ID with the other address
you want to use. When establishing a new subflow, each peer shares its
local address ID. The server can announce address, with an ID. When
sending a RM_ADDR, the ID corresponds to the local address being
removed, so the other peer to which address it corresponds.

The concept of ID is explained in more details in the RFC:


https://www.rfc-editor.org/rfc/rfc8684.html#name-associating-a-new-subflow-w

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

