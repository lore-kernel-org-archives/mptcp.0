Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE62BDC27
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066722; cv=none; b=lSNuzRRzYlk2DWsyTIzA29JtJONn5Jd8AU2WA7g6Tbkc/xpp4j1evXMgtiLD8x+vJaaX0YyVRucXAPom5gMl67KH0uYubB1xzVlgTHuEtsFIIgmEBR7FZFp4cL1b0RRKGd9TLwV/T1xZrwHYG3XaY2//Sbs+h7htZeRALyHOB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066722; c=relaxed/simple;
	bh=ygluPnuwRBC+xyMfU07riKM/p3N34l1isKMkvlwjRu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tAAqL2o/sxBifBzKA6D7ssN3IG0uL/vA/w7iIJGf6oEZkDW8PAStA8L4qPp8OghL1PZOC9hCfSea8aYEYTHqt7K8cYTa4/Nsf++dvBdapuSrbDVNMHhaoDs2skKw++Yw83Ne1tBOpPoE33d5UgQ4+USE9UIBVwUXMQWWRXRLaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd5GWLSq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd5GWLSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6A6C4CEF1;
	Fri,  5 Sep 2025 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757066722;
	bh=ygluPnuwRBC+xyMfU07riKM/p3N34l1isKMkvlwjRu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Hd5GWLSq7i/jCVExAf+E/8tuti041qWZJCaHeqZwJsG7YUkjewBFM0I9xaIQY9Z70
	 EXB3gY/YRezjeOsu511EBOuxiNJ7+ItscbTkFfxzuM6UzNTDXcUCsN+TiTn562/9rs
	 SmvvGE5ax06CIk7qTg2NQwQySqXVWvJ2enCDO5Bnj4/7DIobFrX/PlKWpCmKRt08Jy
	 pljQAu6eZFMEHcsOqsHfW1IwILLaTGOI5EWB9kCAgjfkp7W0f2WKgFeN23cAh4tG3U
	 NrRjhIk3sGAs0E4yCtXS5N9uXSVl7KFuQ1NIyBA6Sy0mhlAv9MVIHrJEp++Yr73qIb
	 6PZmcdE0QxAMA==
Message-ID: <7de753a3852e66e42e3087e14e94de9a95b3ed59.camel@kernel.org>
Subject: Re: Add Multipath TCP (MPTCP) Support to the Java Networking API
From: Geliang Tang <geliang@kernel.org>
To: Alan Bateman <alan.bateman@oracle.com>, net-dev@openjdk.org, 
 "nio-dev@openjdk.org"
	 <nio-dev@openjdk.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, 	mptcp@lists.linux.dev, Gang Yan
 <yangang@kylinos.cn>, Xiang Gao	 <gaoxiang@kylinos.cn>,
 core-libs-dev@openjdk.org
Date: Fri, 05 Sep 2025 18:05:15 +0800
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
