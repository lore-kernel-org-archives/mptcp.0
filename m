Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52996A4E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 09:30:21 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id r14so6481084lfm.2
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KwnZX4HZHysp1fR2K/gtRU8BXGADcAxj4jDOUiY06gw=;
        b=W/EnyviswCuQ4jtDsXmRPJzOoGioIDe12aUq9k4HwKXl0XAkG4O/pFOuGPzmcqQrY/
         t3B40M+lvuXxSjBSWdUKU0xV8Qk+PQblfEo4loD2G72NnxBTRGXalcqZhLQVsJsPFwmB
         4Mf48NR5vvG+ktO/A55X/Bf9HenaLzJoM6Pvfc8zBZ+8hppCnJjhkNq78l1FA44576uL
         2iZfeCcuE6ks2fa7nDamoA4hQhbqcQNciC9CK+bl7pFFY2FZZYDH/Ackfjj9x6LcxcG4
         yi4pii1CS5YUo2j9+z9lAjB2DTSqLG4PV8m4FQCWxshmQ9MLDhUWE+ktW4xw6tyMaCnG
         xokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwnZX4HZHysp1fR2K/gtRU8BXGADcAxj4jDOUiY06gw=;
        b=Hxtym/eCjkezbRBxxvRcBAMbdYKjbb0oHBG/9RAyrjJ6RZP2PU0v8kPy19mucoJkeE
         cF4Gd1EgXejuQi/mYdS6iMkB78YtGcD859ob3EgO8YkSU4OQ2ywZxP20xlI+sdPFeJJB
         RKzdegkdibq9UCnhwNIFVLmv1G0ZGSLWDdQXNL4+EAASrLRkuJfcipQle+RvvKODveJh
         ngorMnn3rcVFuaUWUdnalsekJTH3SZTvxyrB1joNnCferb84a0CqHUP4k7UA/GW6Xeee
         hKXZ4unxkCrJAVNDJKybTAN5Tq02Sx5i6ktykw/7Y1jmnRS/fp6f+6Ig8wb7T06ecUdP
         1k3Q==
X-Gm-Message-State: ACrzQf3PXntkcqCqSYI+zclfV4LAO7M88M8IUcUs7ozkoUEpBUgW9W2a
	1Ij8+wPKTfXaQKHU8QfG5V81njMplgiXL761RqE=
X-Google-Smtp-Source: AMsMyM7bUtiU6MVg2DDh8AmeOuXDlRvA3mae1StClLHwHOObVHKTr+nq6B9kZ1eg6Sh4ognaHIn+AyvhxhgUfzAAEQU=
X-Received: by 2002:a05:6512:3f0:b0:4a2:2ee5:d3d3 with SMTP id
 n16-20020a05651203f000b004a22ee5d3d3mr1445789lfq.307.1665135019245; Fri, 07
 Oct 2022 02:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221006061123.1474224-1-imagedong@tencent.com> <b60b3786-482e-d308-12fa-4f3605301d46@linux.intel.com>
In-Reply-To: <b60b3786-482e-d308-12fa-4f3605301d46@linux.intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 7 Oct 2022 17:30:07 +0800
Message-ID: <CADxym3Zchr+EV4zKnQDs09Epi3DK_gQdC+GtCxhYr_tOwVsgyg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/3] mptcp: add statistics for mptcp socket
 in use
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 7, 2022 at 5:54 AM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Thu, 6 Oct 2022, menglong8.dong@gmail.com wrote:
>
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > In the 1th patch, we do some code cleanup with replease 'sock->sk'
> > with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> > use. And in the 3th patch, we add the testing for this commit.
> >
>
> Hi Menglong -
>
> Thanks for the post. While your patches did apply cleanly to the export
> branch when you sent them, there's now a significant merge conflict
> because of this patch (applied today) that refactors
> mptcp_stream_connect():
>
> https://lore.kernel.org/mptcp/c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com/
>
> Sorry about that timing! Can you rebase and re-post?
>

Okay, I'll rebase and send the v5.

>
> - Mat
>
>
> > Changes since v3:
> > - rename MPTCP_DESTROIED to MPTCP_DESTROYED in the 2th patch
> >
> > Changes since v2:
> > - add testing
> >
> > Changes since v1:
> > - split the code cleanup into the 1th patch.
> > - decrease the statistics for listening mptcp socket inuse with
> >  mptcp_listen_inuse_dec()
> > - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
> >  called on the msk. For fallback case, we need to decrease the
> >  statistics only once, and mptcp_destroy_common() can be called
> >  more than once.
> >
> > Menglong Dong (3):
> >  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
> >  mptcp: add statistics for mptcp socket in use
> >  selftest: mptcp: add test for mptcp socket in use
> >
> > net/mptcp/protocol.c                      | 35 ++++++++++++++++++-----
> > net/mptcp/protocol.h                      |  1 +
> > net/mptcp/subflow.c                       |  3 ++
> > tools/testing/selftests/net/mptcp/diag.sh | 28 ++++++++++++++++++
> > 4 files changed, 60 insertions(+), 7 deletions(-)
> >
> > --
> > 2.37.2
> >
> >
>
> --
> Mat Martineau
> Intel
