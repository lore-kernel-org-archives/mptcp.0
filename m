Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB582F36
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 23:40:37 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6315978pjt.0
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 15:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pwL0f6qdQdYVM5VRohID8qZNEBwlNrmly3cwVpA605c=;
        b=dZI29FsRJaw06KcpQAlFs7VjYatn0ViSZvhlZMhfokznqH74PuWp0F1WIIxrzP6TgX
         DdV6sCGZHomutZITSPNcHtGckfm9Qa60fKMaGl4QV+BG8yHg34+PjrQQLpdEMWmXxY2k
         hUAmqd57dgZh9oBqlvHjf0ahRgNDF/AKtmtJYmZheIjxrkHz00ZEKkQejPdd+WJnVrnb
         g+XygtpIRd+uy99JNMPyJsgGk1u38qTTrEW4/isnv1TOePhGtA6z+2/TxtPTd2b9cMY7
         GpYfAXVCeQOEK7QkplLMgj+0yUzPaLy/Spx+WbLkcD0GSlLQEFqNZJORB0SfKWsdWJAt
         1YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwL0f6qdQdYVM5VRohID8qZNEBwlNrmly3cwVpA605c=;
        b=ASIWaCgOlAC5EXSZkxR1+Omyfr31BwDNbgzT6chF+2HA9E3x9RduRTTVDAu2tJk1l7
         BCL6y03W6XIu2Ah2jKzMs1hu0kmMVxm69+FS/e7VLQduS7TSc1vpbo8kf9WjKLm4KDCD
         LK0IuVuDe6NIblnoNReuwg5OWeFR/GKCIJPlDqZU0k4rVFwgLBrnZDxgpJZ9uaevmS6W
         25Aakz5M9fRzz8AuiFTzQ9TO14eoUiht8q+KSRbMjwGsFwPgzDRfgRuRPEJJ+9O8jNir
         R2C0I5a1spEmhFbFkoyc7FKNwgDWrIUj/ilmZvqulLk8gWXORLnLTbR71njNY0W7YBQp
         dSkA==
X-Gm-Message-State: ANoB5pklaTKup2hwGaHF/W2cc7m0F+opVnMJQ3Wl6WRZ9G4KNou6rrWH
	RJZX4AS0XbjHiUbGR3TNqrRWRRYzMmZRSKhLhFtK
X-Google-Smtp-Source: AA0mqf6AxdSDIbXaGdkL6pZX3JaUGhpGSDR2YMil10FMvtSnJ1+1x9RGHydJuNTiBOcCXCio/Nh1AJ95Ire5LmPOYxA=
X-Received: by 2002:a17:902:a70b:b0:189:b0a3:cf4f with SMTP id
 w11-20020a170902a70b00b00189b0a3cf4fmr36150965plq.56.1670542837326; Thu, 08
 Dec 2022 15:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
 <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
In-Reply-To: <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Dec 2022 18:40:26 -0500
Message-ID: <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, 
	Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 7, 2022 at 9:19 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
> On Wed, 7 Dec 2022, Paolo Abeni wrote:
>
> > MPTCP sockets created via accept() inherit their LSM label
> > from the initial request socket, which in turn get it from the
> > listener socket's first subflow. The latter is a kernel socket,
> > and get the relevant labeling at creation time.
> >
> > Due to all the above even the accepted MPTCP socket get a kernel
> > label, causing unexpected behaviour and failure on later LSM tests.
> >
> > Address the issue factoring out a socket creation helper that does
> > not include the post-creation LSM checks. Use such helper to create
> > mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
> > vs the current user for the first subflow, as a kernel socket otherwise.
> >
> > Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
> > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP content looks good to me:
>
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> I didn't see issues with the socket.c changes but I'd like to get some
> security community feedback before upstreaming - Paul or other security
> reviewers, what do you think?

Sorry, I was distracted by other things the past few days ...

One thing that jumps out is the potential for misuse of
__sock_create_nosec(); I can see people accidentally using this
function by accident in other areas of the stack and causing a new set
of problems.

We discussed this in the other thread, but there is an issue with
subflows being labeled based on the mptcp_subflow_create_socket()
caller and not the main MPTCP socket.

I know there is a desire to get a small (in size) patch to fix this,
but I think creating a new LSM hook may be the only way to solve this
in a sane manner.  My original thought was a new LSM hook call inside
mptcp_subflow_create_socket() right after the sock_create_kern() call.
The only gotcha is that it would occur after
security_socket_post_create(), but that should be easy enough to
handle inside the LSMs.

-- 
paul-moore.com
