Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102373EFD21
	for <mptcp@lists.linux.dev>; Sat, 28 Feb 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269975; cv=none; b=of1ywa4Thy0kJtJCQpwVwHL5bPRegbHT9n1UIXopajMEpa4Hax6vUOTTOhS6Rj5tuQMEaHcGmzgFJtpEvWXuDZ+oC/ztK2lwJ0XucKoDU8fycVJSGKRWcCrlGZ4ap+bx9btdBk3s49ZfjJ5OrmgUZFjiXtsFnyqkEYpd9CBCYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269975; c=relaxed/simple;
	bh=xZCLbbUQs162sJ097sBKXz7R9hRsLTBJsXMnMTlnzqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5ZO5zpkXk8Ldu9d2Xt1qDHLFD/Mid9DyTM8fUvA826OiK0lH/kGD3R/1hZ18kU2vPNqmHYs/DV1USDfJN83k1uayDGjduF4m02zFYJtKHk1dZTi+oR2EFWzsgXRa2wDrNmhI/4HBUhW+Uf8J3rymc6fM5n60iMJ4NkfXLUV8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh5P560N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh5P560N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F3C116D0;
	Sat, 28 Feb 2026 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772269974;
	bh=xZCLbbUQs162sJ097sBKXz7R9hRsLTBJsXMnMTlnzqE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gh5P560NDGyxPtOtxpM2Y20AV2j8Oe5l7cUc+VDFRJVrY+N/H3x/0W8QsuClkQfTZ
	 UUKa0D5PIQgvqI/+Y+seqALXVeSEEHng3VBjpnLjtWAFc3SZMOzTJqOdFcEKQHzdrq
	 aDOLE2poc5WGps3G33LL3jPI9kaCVs4E/X8fAXvE9aw0NOBKX1ozD4fql2/Lr2vty3
	 978iJmMsjrxuzY3PT60V6i5OzQqX5zsu0N2WjYnyHBphDPiFpIsFlLbB03Vn7VkGpu
	 USMQO4pI1+vOaxZ8q2wrtWCqOhhONduIFzk0iUT7/r63ZhHYTX9jHq1oNP+9DE+46F
	 PQcWxNkV3sSkA==
Message-ID: <cfe4ed715628a84625c7fdafcee587581d880338.camel@kernel.org>
Subject: Re: [RFC v2 mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Gang Yan <gang.yan@linux.dev>, 
	mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Sat, 28 Feb 2026 17:12:49 +0800
In-Reply-To: <f3235ddf-9d39-42a7-8e44-a847b7402e39@redhat.com>
References: <20260203023029.855434-1-gang.yan@linux.dev>
	 <f3235ddf-9d39-42a7-8e44-a847b7402e39@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

On Thu, 2026-02-12 at 10:04 +0100, Paolo Abeni wrote:
> On 2/3/26 3:30 AM, Gang Yan wrote:
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index cd5266099993..8b243062009c 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -267,6 +267,7 @@ struct mptcp_data_frag {
> >  	u16 overhead;
> >  	u16 already_sent;
> >  	struct page *page;
> > +	u8 eor;  /* Is MSG_EOR marked? Prevents coalescing with
> > next frag */
> 
> I'm sorry for the late feedback, but the above will waste quite a bit
> of
> memory due to alignment. I think you can change the 'overhead' size
> to
> u8 and place 'eor' after such field.

I completely agree.
I think it's better not to let 'eor' use all 8 bits here; just one bit
is
sufficient, leaving the other 7 bits for future use, similar to:

	u8 eor:1,
	   __unused:7;

I changed the state of this patch as "Changes Requested".

Thanks,
-Geliang

> 
> Such change could be paired with build time check vs 'overhead'
> overflow. i.e.
> 
> 	BUILD_BUG_ON(ALIGN(1, sizeof(long)) + sizeof(struct
> mptcp_data_frag) >
> U8_MAX);
> 
> /P
> 

