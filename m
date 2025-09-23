Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4F2EDD5D
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614613; cv=none; b=jDfhmUBRHwxFro3xSi9dH1/sPZH5qoGsDOhO+5ZncMkM7jBvoerayogYoDfUMU0NhXZY5yDNj8dl35YrgeRXAGpOniJanK6CqgAVzGZeJ0VTXf3B6sC2UrLhRnx711vZTk2IWKDelPJ6/cm8e4B78Fr+aXA0XcM8Oj02vIpyJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614613; c=relaxed/simple;
	bh=LzMMfzKU7T+i/CXW0y2AQB/UMX3QONfdsXn9wla4ehg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WglYaROzDOIu2uckeqFH63AAtLEo9HYYiwa+TW3x2YST1fuxWPaIT0GZzPmZKIQr0qQ2SCWt7q6BUFIUknEB2RjeoFw2jvz5rr1rZR1Tv2UqeRO/YK1zQIk0WoZZSzJ3HP8r/mGe85l8uYqLuzHYpkOPSHW7mdNU8fWkVTps9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEaj6Lh2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEaj6Lh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BABC4CEF5;
	Tue, 23 Sep 2025 08:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614612;
	bh=LzMMfzKU7T+i/CXW0y2AQB/UMX3QONfdsXn9wla4ehg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GEaj6Lh2KIGHBgkLDxl06V2bDW8Dl8h5QNWKKDyRphUNLjyqdJj/0j1UpGpiJekkO
	 IHrmx6rSN+G8G4P9dxeH7PkO1j5GUibgE0cvY6HuiydNHN6OAOr3AwyX3I9a9ZNIvW
	 BEsHlKP1yuXWUbxi0z4vQqHT5Rq19WgD5PnYvO7ijnbLvL0K+QuUUrWdG9QGrXS+ot
	 De58dImv45kNW/dGF3YR0dnlTnkHctnikfq8uFKuvupF5AoAhiUygbQcsJ73GUMH/I
	 3sYOgfEVPoXadt+Y1hm4ND8AsQ/77FOAoLGa8HAPw54wXvonJGwdSgp+//a/DbV9PT
	 mlOpoJKlMkdtw==
Message-ID: <8ab7f8a1452b6660e97b757286cfe2d6a7faafd4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm: fix pm_nl_ctl build
 errors with old glibc
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 23 Sep 2025 16:03:27 +0800
In-Reply-To: <20765ed6-3164-4df7-b125-2ee04e90bb23@kernel.org>
References: 
	<092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
	 <20765ed6-3164-4df7-b125-2ee04e90bb23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-09-23 at 08:53 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/09/2025 02:42, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Compiling pm_nl_ctl on older versions of glibc will report the
> > following
> > errors:
> > 
> > '''
> >   CC       pm_nl_ctl
> > pm_nl_ctl.c: In function 'capture_events':
> > pm_nl_ctl.c:204:53: error: 'MPTCP_PM_EV_FLAG_DENY_JOIN_ID0'
> > undeclared (first use in this function)
> >   204 |                                         if (flags &
> > MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
> >       |                                                    
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > pm_nl_ctl.c:204:53: note: each undeclared identifier is reported
> > only once for each function it appears in
> > pm_nl_ctl.c:206:53: error: 'MPTCP_PM_EV_FLAG_SERVER_SIDE'
> > undeclared (first use in this function); did you mean
> > 'MPTCP_ATTR_SERVER_SIDE'?
> >   206 |                                         if (flags &
> > MPTCP_PM_EV_FLAG_SERVER_SIDE)
> >       |                                                    
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                                                    
> > MPTCP_ATTR_SERVER_SIDE
> > '''
> > 
> > To fix this, this patch redefines MPTCP_PM_EV_FLAG_DENY_JOIN_ID0
> > and
> > MPTCP_PM_EV_FLAG_SERVER_SIDE in pm_nl_ctl.c.
> 
> You shouldn't get this error, because this file is supposed to be
> compiled from the kernel source directory, or at least using the
> kernel
> headers built from there
> 
> How do you compile this file? Are you not using the Makefile in the

I got these errors when compiling the bpf selftests with the commit
"selftests/bpf: Add mptcp pm_nl_ctl link" using mptcp-upstream-virtme-
docker:

https://patchwork.kernel.org/project/mptcp/patch/8cdb0df7316a6baa93df88b0fe78aaa710f3bb72.1738924354.git.tanggeliang@kylinos.cn/

Thanks,
-Geliang

> same
> folder? Or do you have a separate build dir and you didn't specify
> KHDR_INCLUDES?
> 
>   make headers_install INSTALL_HDR_PATH="${HEADERS}"
>   make KHDR_INCLUDES="-I${HEADERS}/include" \
>        -C tools/testing/selftests/net/mptcp
> 
> Or use the kselftests scripts:
> 
>   make -C tools/testing/selftests TARGETS=net/mptcp install \
>        INSTALL_PATH=${INSTALL}
>   cd ${INSTALL}
>   ./run_kselftest.sh -c net/mptcp
> 
> 
> Cheers,
> Matt
