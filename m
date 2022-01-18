Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67497173
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642512767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EwN/LCDsqFnNn3NE016X5CYVWyx71xa9iONGj0YfpA=;
	b=BMzvGF988Rn89oxQ/zpAOmAlL5XaWTzJC3+x/g99FAtKY02yQGBeDs4bIxn2oqj4KuTCQ+
	lYbNlalGwEKcduSoiWYtIxGrORtkF+MjYSdhu52phhXvUhEHJNsbqdxkqA0Zc/NeJ9/LWr
	CWZiVs+h4EWlGX2v8EJ9ARUdhQ2/c9w=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-giFrC-JQNYK2TQ4AFHoMVw-1; Tue, 18 Jan 2022 08:32:46 -0500
X-MC-Unique: giFrC-JQNYK2TQ4AFHoMVw-1
Received: by mail-yb1-f198.google.com with SMTP id x9-20020a25ce09000000b00612eb11922aso2423436ybe.9
        for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 05:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EwN/LCDsqFnNn3NE016X5CYVWyx71xa9iONGj0YfpA=;
        b=mEzHsOJ/DhjoAcAx8wptp+IFTajzf+Ur8wV6CeJNuS8Jc2aTlgVZMpsFVaaeNjnw5N
         mBZ4Dk/L0QSXmBNTeUYXYt03WyEMXLDz/yGCdVfhV0pqu52NbIt68dzUyzDPEiOTtBMN
         r74/xXAw4lPiQpeNS1JrezOjC3Mwk8K8m1QL/adpbophZlP+gXSIhrOS5jQjJL0STkAA
         K4daekB87ac/UcyhAGanFmwAkX29oKcP4xXwRymF3v0P1qBOQSaOWK0TmASMMaQD0Mkg
         C0esEXxN7e3auRFi6Odnu/w/3p92sXSuwnbKNVYAf7iLF2HH8TM9N99h5LTXG9PlfNpf
         iokw==
X-Gm-Message-State: AOAM532VIQViG7pMQ4oNUkZd5e0wnGJjXQlr7mGlOL/YhLXQDyEtpQ36
	M2dI0wYgP1vEITtoz7FwsnMz8qWb994D0hVsNJHj9TH5oe/30RZVeS3EnnnK4xmKUG21N2kqZr1
	ynSnyv2ghZMGFl/W6VgPqYYwK98Q6MAk=
X-Received: by 2002:a25:2743:: with SMTP id n64mr32683766ybn.417.1642512765592;
        Tue, 18 Jan 2022 05:32:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWhQG7cqO23DpUlcnicn1/1znBqUo3zyuNCp/7o9dj0EqAz0I+kzp3g5YoOm1f8MHCyrQGWBeHSJZ8KgKyoBc=
X-Received: by 2002:a25:2743:: with SMTP id n64mr32683736ybn.417.1642512765319;
 Tue, 18 Jan 2022 05:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1641804767.git.geliang.tang@suse.com> <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
 <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com> <a1679740-24ed-c788-46df-ad195068dd37@linux.intel.com>
In-Reply-To: <a1679740-24ed-c788-46df-ad195068dd37@linux.intel.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 18 Jan 2022 14:32:34 +0100
Message-ID: <CAKa-r6sgL1UUES5WYryNYedLJuq0_dEsO=X1263GFPOExci6BQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail testcases
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Geliang Tang <geliang.tang@suse.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

hello,

started looking at this, but the wild-guess is that the problem should
be fixed with [1]: I'll do a quick test on my VM now.

-- 
davide

[1] https://lore.kernel.org/netdev/20220110094750.236478-1-eric.dumazet@gmail.com/

On Thu, Jan 13, 2022 at 6:09 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Wed, 12 Jan 2022, Mat Martineau wrote:
>
> > On Mon, 10 Jan 2022, Geliang Tang wrote:
> >
> >> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> >> checksum failure.
> >>
> >> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> >> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >> ---
> >> tools/testing/selftests/net/mptcp/config      |   5 +
> >> .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
> >> 2 files changed, 107 insertions(+), 9 deletions(-)
> >>
> >
> > Does anyone else see the "leaked reference" errors when running these fail
> > tests with the latest export branch? Looks like the reference tracker finds a
> > tc-related error:
> >
> > [  238.871372] leaked reference.
> > [  238.872393]  fl_change+0x2db/0x2520
> > [  238.873148]  tc_new_tfilter+0x6c4/0x11f0
> > [  238.873959]  rtnetlink_rcv_msg+0x49f/0x640
> > [  238.874798]  netlink_rcv_skb+0xc4/0x1f0
> > [  238.875570]  netlink_unicast+0x2d5/0x410
> > [  238.876364]  netlink_sendmsg+0x3b3/0x6c0
> > [  238.877155]  sock_sendmsg+0x91/0xa0
> > [  238.877890]  ____sys_sendmsg+0x3ad/0x3f0
> > [  238.878684]  ___sys_sendmsg+0xdb/0x140
> > [  238.879354]  __sys_sendmsg+0xae/0x120
> > [  238.879947]  do_syscall_64+0x3b/0x90
> > [  238.880683]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > It doesn't look like MPTCP is to blame, but I'm curious if others see the
> > same.
>
> I've attached my kernel config as Davide requested in the meeting today.
>
> I had applied this version of the "Clarify when options can be used"
> series to export/20220111T054942, which is based on net-next/master at
> fe8152b38d3a (still the current HEAD).
>
> --
> Mat Martineau
> Intel

