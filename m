Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4C2BE63F
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067088; cv=none; b=CtxNnyZhKSLJgpjUwZR3/FaktRbG6F5hOXq8uy3R1Sh1m+q6TCYAlWLIIOhjIlar/L/KX943BDiKFSvywZxkjugB0vuSyuKjVuT4HDbmE/JnHo4t3a2iAgXdfX1/QUOnUfTKwDi1jblZf0leZT0SfqJqW14ssUdJpa8EzVeUJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067088; c=relaxed/simple;
	bh=ygluPnuwRBC+xyMfU07riKM/p3N34l1isKMkvlwjRu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VngIdQvHawD7gp/jsUqURGNbO4cTn0DU7HwGMZMYqqn3+7mPIYSvkYDDxAAfxbdJxEueAF1mbnT92LNXlJMER/Bcrx/IPk6P2nJuyH+Loi82mHN/8nQ20TyHFOLN+Xr/tUQ7QeuuH3ACXn9mbK1saWdG9wFwoJpBkfqnSEx7RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEq2rI//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEq2rI//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81464C4CEF7;
	Fri,  5 Sep 2025 10:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757067087;
	bh=ygluPnuwRBC+xyMfU07riKM/p3N34l1isKMkvlwjRu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aEq2rI//OuMxVpRlpm+2+JCQvDFDXSpX5nFenWs3xwwFhxbkRxPzgc9tFmY4/vWrN
	 P481z4RroTwx6jnZ1yVtJqqmkhAQbKoTfUHlS8RqebaJYfhMElKR5A6r8lQA5fyPj6
	 54Z/lZzLeSoXemndKD0WotfeUjjNVRDLx3m+KZVLEaadzjPUStl6m9Fqs8Dhjs2dQ/
	 NcI+bB81y/dsO8LiPLHj5CevWQaKsq8c0CZ6117YnaNscDsC3nJ2LtmOmcFEVwQWvc
	 TpE4TgPDdvIMS6ddQ64yd0iBoflf4BPO+pd0JtUI5+XAERW8XDwBOzZm30ehxEs5yC
	 rSNidQmy98n0w==
Message-ID: <c01f7f30efd2f9fb3185f9ad82579eca8a613ac3.camel@kernel.org>
Subject: Re: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: Alan Bateman <alan.bateman@oracle.com>, net-dev@openjdk.org, 
 "nio-dev@openjdk.org"
	 <nio-dev@openjdk.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>,
 core-libs-dev@openjdk.org
Date: Fri, 05 Sep 2025 18:11:22 +0800
In-Reply-To: <7403952e-14c1-4ba2-871e-0e2174fd5167@oracle.com>
References: <da3912a3e0b03974305513219621856d33f82219.camel@kernel.org>
		 <7403952e-14c1-4ba2-871e-0e2174fd5167@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alan,

Thanks for your reply.

On Fri, 2025-09-05 at 10:28 +0100, Alan Bateman wrote:
>  
> On 05/09/2025 09:43, Geliang Tang wrote:
>  
>  
> >  
> > :
> > 
> > 3. Proposed Java API Changes
> > 
> > The goal is to allow Java applications to opt-in to using MPTCP
> > when
> > creating sockets, without breaking existing code. The proposed
> > changes
> > are additive and backward-compatible.
> > 
> > The core idea is to add a boolean mptcp parameter through the API
> > layers, from the public Socket class down to the native system
> > call.
> >  
>  
>  (moving the discussion to nio-dev and net-dev).
>  
>  Adding new constructors to legacy Socket/ServerSocket may work for
> your initial prototype but would be problematic to propose as it
> would bake non-standard features into the standard API. Also many
> high performance servers use SocketChannel rather than Socket.
>  
>  One suggestion for a next prototype is to model the enablement of
> MultiPath TCP as as a JDK-specific socket option (see
> jdk.net.ExtendingSocketOptions). All of the standard APIs for
> networking sockets define a setOption method for setting socket

I was initially concerned that calling setOption() after Socket()
creation to convert TCP to MPTCP was too late. Creating an MPTCP socket
must be done during the socket() system call.

> options. If modeled as a socket option then enabling can create a new
> AF_INET6/SOCK_STREAM/IPPROTO_MPTCP socket and then dup2 it into place

Until I saw here, it should be feasible if the socket can be created
again and dup when calling setOption().

I will try to reimplement MPTCP support using
jdk.net.ExtendingSocketOptions soon and give you feedback.

Thanks,
-Geliang

> so that the original AF_INET6/SOCK_STREAM/0 socket is closed.
> Enabling can be made to fail if the socket is already bound. It could
> copy over existing socket options if needed. Look at the built-in
> (and no longer used) SDP support for an example that does similar
> with AF_INET_SDP/SOCK_STREAM/0. The only API surface would be a
> socket option defined in jdk.net.ExtendingSocketOptions.
>  
>  -Alan
>  
>  
