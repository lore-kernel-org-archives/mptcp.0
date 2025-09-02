Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B63375A7
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831425; cv=none; b=fMZ31GQ5cA4QOFhgZef+vdVNSyJzz0xeAvwGhhKIZCusn26pAayfqenCTtfcm3CC8iQQpQGmiXkbWRSe+gCVL/FRah5S52bx57XGhxygfngj4qAXQ/pBjI4SvjCChctoy6VKLR+uSJwfl9C3PBw06Qr9n6UpmzAyH+/Cc1UhMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831425; c=relaxed/simple;
	bh=VCL+14MV8m40OavWH9LX5hZSp8nbOs4phVLo/88I1fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hInll/h3ZPUa6ENTySbGqpi3tB4jBYviHmkZ9RaPgFDWtQk3NxsgYx2ddqrgRDIQqWMqlHwvzQyNOFSpDB1cWPg6sxtv4TeCUGgDl66y+paOvj9DT5YE0p9w4JN9e2dUXlUXoNkJZcYCv2XJUXXmzzDyMS4+oOnTuwOtVURRcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=U0INbRXN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="U0INbRXN"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f646b1db8so5387277e87.0
        for <mptcp@lists.linux.dev>; Tue, 02 Sep 2025 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756831422; x=1757436222; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T51/XIVN6Aj4qBBeACITFP+6V6KcPe34ZRkP6zn27J0=;
        b=U0INbRXNB/cxSKmGmHvbHQ5VsgHcAkKMWQqiee4ktyMGcyMIy+Gau3oCkVQxozeIFU
         FIC1/x+cG18XPe70/JmmHR9icXFsLSKC/Yru9qE3qrjnnUGjjtU81gkt1aIdnmKUMSbv
         RvhUGGWgl8ZGWoxlxkYwBRCTrltKZD15uM9EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831422; x=1757436222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T51/XIVN6Aj4qBBeACITFP+6V6KcPe34ZRkP6zn27J0=;
        b=l1xKgoFkJFrZ6bKlhLSVjS8/v4mrq3KTVIqIAYX7Gy0F9RngcmQdk+trW6XEf+6Q3G
         VehPIhFol1e8BYfHrLvw+xgdbMk1uyLLjPWbK1jWU3nRCoPeg+tJbhhuc3mWii0++seR
         o6pzd0ofvKnX9HR2U7Gb+E7Lxein+s0OJmUMGw6XCnzVG5+LH7Hxt9eBBS2mZX21ppEp
         M+4pZ3S84iB7udtjRr3UMwNvbcg0oEK5N80BJp657dSkBVAxfU/rMnMG8pCzxCL9q+/Q
         jxTOP+X+kfK6FgWbckQw88gp37pF0oasmRY16TC6SrL3OnLbWOo/PKd8nGC6EjjDlMcq
         0vQg==
X-Forwarded-Encrypted: i=1; AJvYcCVHJfju5WUQNprKtKRse1WPNd72fx33ZPfkvvguTwlZgxzjen91++bkB7BKRktBwzJt3lG5yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0akCvnuMm9Qy9okwR7OXxacHci4teVFkxet5TtcetSHs9ljXD
	yjL+j2Z1i16kyLAts2wHQOqoLygqjEiOHIFSd/ksWC8ufp2SnziSH+l3FkgSEsZ9mYnC2xzGSgK
	8mF+2+1fvNIAuaFiNDM2mIyZJG8VExtYF9EI7JYQipg==
X-Gm-Gg: ASbGnctpHGqMP+w2QcyXncej2NVPZMmdtuG4rbrbet6C4zuGt2AS2pyQ8msj5InF2ij
	LLeOqLmwolRTdcwGla8pgR3HnA2DKvDM9EqNhvWyI879qq0casB7X2+bf0iRpeL2idVrVMajSCg
	rAKIQ8jAMCL/mzt6f3iJcYwE3dwB5eD0yCWQKpvqBdoUONGYfL1cQfHR51YR05AUp99KYrbRSAX
	0ZiwMVZ5ypzLdh/AgZc8ek3gN9dceNomjKH9pK7KlHdb9/wYeOR7PMbd4mxaMYfig==
X-Google-Smtp-Source: AGHT+IGSpyfuPVZtbd9guoKkY4Nt76Sa2LW0Y0LCC00TR+o3W/GkM+tQx1tDa/UvpU+BTuP3V+Na73Nb4ez93WmmAYs=
X-Received: by 2002:a05:6512:12c5:b0:55f:394e:3b with SMTP id
 2adb3069b0e04-55f708a2b89mr3757092e87.10.1756831421642; Tue, 02 Sep 2025
 09:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
 <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org>
 <CADg4-L_yzQo7Xs3aVL=sBY2M6OwZ=XDHCTdaS3KyiZa0hOct0g@mail.gmail.com>
 <9de05bc0-fcf6-364f-b143-fb72cb8c4cae@kernel.org> <8d4ba38a-e19d-408b-b81d-a75362d170e2@kernel.org>
In-Reply-To: <8d4ba38a-e19d-408b-b81d-a75362d170e2@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 09:43:30 -0700
X-Gm-Features: Ac12FXwFnOiVY1o6TiM8iJoPiIbv6zHSVSU5dkFxysW8ObpTOLLuoBxHwZc3K1I
Message-ID: <CADg4-L-LPJ1SNHzDVtosn3S-_1Uh9+9YhwThX24+mB9x2LHcDg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 2/7] mptcp: pm: userspace: respect deny_join_id0 attr
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:08=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Christoph, Mat,
>
> On 30/08/2025 02:58, Mat Martineau wrote:
> > On Fri, 29 Aug 2025, Christoph Paasch wrote:
> >
> >> On Fri, Aug 29, 2025 at 1:33=E2=80=AFPM Matthieu Baerts (NGI0)
> >> <matttbe@kernel.org> wrote:
> >>>
> >>> During the connection establishment, a peer can tell the other that i=
t
> >>> cannot establish new subflows to the initial IP address and port by
> >>> setting the 'C' flag [1]. The RFC8684 is strict about that:
> >>>
> >>>   (...) therefore the receiver MUST NOT try to open any additional
> >>>   subflows toward this address and port.
> >>>
> >>> It is then important not to let the userspace PM establishing such
> >>> subflows, and return an error (ECONNREFUSED) if it tries to do so.
> >>>
> >>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
> >>> establishment")
> >>> Link: https://datatracker.ietf.org/doc/html/rfc8684\#section-3.1-20.6
> >>> [1]
> >>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>> ---
> >>>  net/mptcp/pm_userspace.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> >>> index
> >>> 1911fe1799fa38a53381247a830a9a0daf1c4492..9968dc9a8b45112114953f66848=
ea22c971136d6 100644
> >>> --- a/net/mptcp/pm_userspace.c
> >>> +++ b/net/mptcp/pm_userspace.c
> >>> @@ -391,6 +391,12 @@ int mptcp_pm_nl_subflow_create_doit(struct
> >>> sk_buff *skb, struct genl_info *info)
> >>>         if (err < 0)
> >>>                 goto create_err;
> >>>
> >>> +       if (READ_ONCE(msk->pm.remote_deny_join_id0) && addr_r.id =3D=
=3D 0) {
> >>
> >> If userspace wants to, it could still work around that by still using
> >> the initial subflow's IP-address and just use a non-zero address-ID.
>
> Good point, I missed that!
>
> >> Is that really a concern ? Sure, the IETF-draft says "MUST NOT", and
> >> so, shouldn't we leave it up to the userspace PM to make that decision
> >> ?
> >>
> >
> > I concur with Christoph on this one, I think the PM (userspace or
> > kernel) is responsible for this aspect of the protocol so it doesn't
> > need to be double-checked here.
>
> Indeed, we could leave it up to the different PMs to make that decision.
> Initially, I didn't have this patch, and I had a simple patch setting
> the corresponding sysctl to 0 in userspace_pm.sh, just to check the
> event was correctly announced. But when writing the last patch's commit
> message ("mptcp: pm: nl: announce deny-join-id0 attribute"), I realised
> that the main missing feature was a way for the userspace daemon to know
> that the C flag was set. We cannot backport patch 7/7

Why not ? Yes, it is not typical to backport a new netlink message,
but I think it makes sense here.
It basically means that the fix involves not only the kernel but also
the userspace PMs.

> , but we can
> backport this one, and have a way to know this info on older kernels. I
> should have mentioned that in the commit message.

The problem is that even this here is not complete, right ? A
userspace pm can still attempt to connect to the IP of the initial
subflow simply by using another address-ID.


Christoph

> In this case, I think we have a few options:
>
> - Keep this patch, but update the commit message to make it clearer
> what's its purpose, see [1]
>
> - Same, but revert it after patch 7/7 on net-next.
>
> - Keep it, but also check for the address and port.
>
> - Drop it.
>
> What would you prefer?
>
> Personally, I think we should keep it, at least for stable, but we don't
> need to check for the address and port: even if it is easy to check, it
> might be good to let a way for the userspace to still create such subflow=
.
>
> [1]: The last paragraph in this commit message would then be:
>
> > It is then important to let the userspace daemon know it is not allowed
> > to establish such subflows, and return an error (ECONNREFUSED) if it
> > tries to do so. Note that the userspace daemon will still be able to
> > establish subflows to the initial IP address and port, but by giving a
> > different remote ID: that's OK, that's its responsibility ; worst case,
> > the MP_JOIN is rejected by the other peer.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
