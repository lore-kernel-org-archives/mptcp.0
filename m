Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255D26E71F
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582030; cv=none; b=IkZe5C/QHf1OAkFAdKOXCt+A2TCnTzEaAo+nPF2YnxukwYIGL+o1SdxFWLyLlhAgBu2lbfTuqalBml+zJQ3y87CF23EUSYUWQ6qJlNyVKLNuqBjmm0NC2vU88PFCit4sMwdBHPaIOAIQ74ffv0rtp4FGeWix9rLQCxtgV8ARTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582030; c=relaxed/simple;
	bh=YjHdrOGNj9bQnkZ5Sfb55sQCm/nCJBTqPxTbCrb5RWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHrXZ/15ilXsNyOowcbd70pHWHATHzKEtAitkNeqrDsj1gy+0mM5IeulzwcttHcO/FuNg9Z6n+NpXl6fsxwrs/9N9x+6NTjz9B4ehRWPZ3uMadU2uX0llMapGAv+TpjZXrE12SQfOkOiLOH3NOVog/y30vX/wCgC+/aLZFyd7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vrk0K//K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vrk0K//K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7703C4CEF0;
	Thu, 11 Sep 2025 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757582029;
	bh=YjHdrOGNj9bQnkZ5Sfb55sQCm/nCJBTqPxTbCrb5RWg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vrk0K//K9qUI59bUWGH2dH6F1WsTqiTPGqMYYXBWO4HovhgkyGD/upI0thX3Ntxio
	 WHo82E6TeJB24F4/4R0y0nnqW7VUSOzQMSpXvA1nKq+spR+3JQ7OM34/ZcgsDoFjwg
	 yYfsUSUvVP0gewIntl0Ybw4oKBfTedu5SyMCK/O2MCFLXNyFk20HUjcEGa4Wxaiqzu
	 zvtaUu/Is44LNjo8kPEraV0YWKWsN77Sx7xjMG/NYqr8fzf56kykd7XYKDIggBnake
	 2dlcpuAzjHx3ta5veJxYL75Fp8WnOecHOCVsZTr9OOSvnT5MfKJE3PYpkekIBYPY8n
	 L0wssdULOA96Q==
Message-ID: <3b2ba3137ec9ed4f4f418f94bf14c85c0d99f724.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/3] selftests: mptcp: close IPC descriptor
 on server side
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 11 Sep 2025 17:13:45 +0800
In-Reply-To: <76dd22aa-7071-4f55-a8ed-21283bf8c2cf@kernel.org>
References: <cover.1756872050.git.geliang@kernel.org>
	 <64f5ec5170dd363b19af13fd127a77baa8288104.1756872050.git.geliang@kernel.org>
	 <d512f8fc-a0ac-4c23-9a13-0b5c4e1ed20f@kernel.org>
	 <ea8ac8aff352d819b9caa0abee2ae272991bd2ff.camel@kernel.org>
	 <76dd22aa-7071-4f55-a8ed-21283bf8c2cf@kernel.org>
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

On Wed, 2025-09-10 at 19:00 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 04/09/2025 10:26, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Wed, 2025-09-03 at 13:57 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 03/09/2025 06:08, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > The client-side function 'connect_one_server()' correctly
> > > > closes
> > > > the IPC
> > > > descriptor (a pipe or UNIX socket) after use. However, the
> > > > server-
> > > > side
> > > > functions 'process_one_client()' in both 'mptcp_sockopt.c' and
> > > > 'mptcp_inq.c'
> > > > were missing the corresponding 'close()' call for their IPC
> > > > descriptors.
> > > > 
> > > > This omission could lead to resource leaks (file descriptors)
> > > > in
> > > > the test
> > > > server processes over time.
> > > > 
> > > > This patch adds the missing 'close(pipefd)' and 'close(unixfd)'
> > > > calls in the
> > > > server-side code, ensuring symmetric and correct resource
> > > > cleanup.
> > > 
> > > I don't know if we need such patch. I mean: yes, that's better to
> > > close
> > > such FD before closing the application, but then:
> > > 
> > > - it is strange to close it in the middle of a function
> > > (process_one_client()), and not where it has been created
> > > (main())
> > > 
> > 
> > Yes, close it in main() is much better. I added close(pipefds[1])
> > after
> > calling server(pipefds[1]) in the new version instead of adding
> > close(pipefd) in process_one_client().
> > 
> > > - if I'm not mistaken, unixfds[0] / pipefds[0] are not closed in
> > > the
> > > server process.
> > 
> > Yes, indeed. close(pipefds[0]) is missing in the server process
> > too.
> > 
> > > So if you really want to fix that, I think it would be better to
> > > close
> > > all these unix FD in the 'main()' function, no?
> > 
> > I also moved 'close(pipefd)' from connect_one_server() to main(),
> > just
> > after calling client(pipefds[0]). And here's the new version:
> > 
> >         e1 = pipe(pipefds);
> >         if (e1 < 0)
> >                 die_perror("pipe");
> > 
> >         s = xfork();
> >         if (s == 0) {
> >                 close(pipefds[0]);
> >                 ret = server(pipefds[1]);
> >                 close(pipefds[1]);
> >                 return ret;
> >         }
> > 
> >         close(pipefds[1]);
> > 
> >         /* wait until server bound a socket */
> >         e1 = read(pipefds[0], &e1, 4); 
> >         assert(e1 == 4); 
> > 
> >         c = xfork();
> >         if (c == 0) {
> >                 ret = client(pipefds[0]);
> >                 close(pipefds[0]);
> >                 return ret;
> >         }
> > 
> >         close(pipefds[0]);
> > 
> > Is this better?
> 
> (sorry, I thought I replied...)
> 
> Yes, that looks more manageable like that: all close() by the
> "function
> owner" (where they have been opened).
> 
> Also, please don't bother about closing all FD in the error exit
> paths,
> e.g. in xfork(), etc. when xerror() is called. These are more
> unexpected
> errors, and closing everything properly is this case, for the
> selftests
> is not a priority, and might cause issues if the code is more complex
> (+
> issues for the backports, etc.)

I agree, the priority is really low. I think there is no need to
backport these three patches. Should I change them to -next from -net
in v3 and treat them as cleanups instead of fixes?

Thanks,
-Geliang

> 
> Cheers,
> Matt
