Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABEB2C08BB
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974378; cv=none; b=q73ccrRSMv23ZnNKGri0DTvQO/r4uwgwFMSgpI9cDRjutzEOad/i1Y3LBqUlAeJrWlWVYPSKSsPxjSm49mXe6A333EPdt3B6qyCBcvJtGt9Cb4u3wIyFiYy1RoKnYetMj/2VOpPWN44Slx7C6QykuyYDGR78tr5uJOeciU9/eA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974378; c=relaxed/simple;
	bh=4hKD8x05hnztYSVUYctrop79IgUCaBZDIvLvbUWvBkk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTox0rKEYq0FHlST3Rj69XiKJ/7C1YY+ybRe0Jxc2SLyJh9dQC9a1l/FXeoYri3WpkYXgna4nm8qiv6ayJEo8ZgCxHhM6CCqZUZioAgpG7Lpg9DXWkd4C9RVOHch5TWnoJc+lrmv1yuCzg+P7BgLpkW8CXcDlLYhK2hNwxTXc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epffc11f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epffc11f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504DDC4CEF1;
	Thu,  4 Sep 2025 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756974378;
	bh=4hKD8x05hnztYSVUYctrop79IgUCaBZDIvLvbUWvBkk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=epffc11fe0ffrhMp0L/7iMGKvnJgkoplEZZHBlyHbEePlVPBQ/ySMBCjvk9ik7OdX
	 uuuCyAORRETusYZfXJzTg6SkM8GtvuQiU/JVwZxYVaOEHyB85TmLtqvX/MH7GSwcmU
	 cF7aSngZbuTF6flcYgOJFHzpQcnJR8KHt29BcC30Vlc+3Y3MN69zKObt7Ovp32uHGx
	 S5TAjBA7w0Kq500gQ/nts3iXfQf6G60OSUPuLYX+ZgjJECkS3PsRFsKx8ztMTH1fm5
	 vIUZ110G+GK55meDnbK0MIDGap2FHDYwfM/+fB2nJeDnPE+EuhhFpmNtd8cO9+G7zt
	 ch1S+U0WQQ/dw==
Message-ID: <ea8ac8aff352d819b9caa0abee2ae272991bd2ff.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/3] selftests: mptcp: close IPC descriptor
 on server side
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 04 Sep 2025 16:26:13 +0800
In-Reply-To: <d512f8fc-a0ac-4c23-9a13-0b5c4e1ed20f@kernel.org>
References: <cover.1756872050.git.geliang@kernel.org>
		 <64f5ec5170dd363b19af13fd127a77baa8288104.1756872050.git.geliang@kernel.org>
		 <d512f8fc-a0ac-4c23-9a13-0b5c4e1ed20f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Wed, 2025-09-03 at 13:57 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/09/2025 06:08, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The client-side function 'connect_one_server()' correctly closes
> > the IPC
> > descriptor (a pipe or UNIX socket) after use. However, the server-
> > side
> > functions 'process_one_client()' in both 'mptcp_sockopt.c' and
> > 'mptcp_inq.c'
> > were missing the corresponding 'close()' call for their IPC
> > descriptors.
> > 
> > This omission could lead to resource leaks (file descriptors) in
> > the test
> > server processes over time.
> > 
> > This patch adds the missing 'close(pipefd)' and 'close(unixfd)'
> > calls in the
> > server-side code, ensuring symmetric and correct resource cleanup.
> 
> I don't know if we need such patch. I mean: yes, that's better to
> close
> such FD before closing the application, but then:
> 
> - it is strange to close it in the middle of a function
> (process_one_client()), and not where it has been created (main())
> 

Yes, close it in main() is much better. I added close(pipefds[1]) after
calling server(pipefds[1]) in the new version instead of adding
close(pipefd) in process_one_client().

> - if I'm not mistaken, unixfds[0] / pipefds[0] are not closed in the
> server process.

Yes, indeed. close(pipefds[0]) is missing in the server process too.

> So if you really want to fix that, I think it would be better to
> close
> all these unix FD in the 'main()' function, no?

I also moved 'close(pipefd)' from connect_one_server() to main(), just
after calling client(pipefds[0]). And here's the new version:

        e1 = pipe(pipefds);
        if (e1 < 0)
                die_perror("pipe");

        s = xfork();
        if (s == 0) {
                close(pipefds[0]);
                ret = server(pipefds[1]);
                close(pipefds[1]);
                return ret;
        }

        close(pipefds[1]);

        /* wait until server bound a socket */
        e1 = read(pipefds[0], &e1, 4); 
        assert(e1 == 4); 

        c = xfork();
        if (c == 0) {
                ret = client(pipefds[0]);
                close(pipefds[0]);
                return ret;
        }

        close(pipefds[0]);

Is this better?

Thanks,
-Geliang

> 
> Cheers,
> Matt
