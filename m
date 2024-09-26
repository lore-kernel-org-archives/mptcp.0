Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0622615
	for <mptcp@lists.linux.dev>; Thu, 26 Sep 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359571; cv=none; b=fy0PebRjIvUDCv1b4nC9qT/WcItbWzyQXo74uIebzzQOHyfZ7hxS0av3PFksgdZAz6pvT8UuvRmhgCiN44jax+ph7z2b6CQ4ps3MP/Ph7X3BVVZsFv7j1tcr067MaKWngH3AKIMgSgFD0TKqZ5Yv0uX/KvxnSZKcfgnxnQ1uf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359571; c=relaxed/simple;
	bh=efqQHGyq4qHIhTXxFRRFoAlfmIC0PyI8e//jzk3p78U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oIsWNoDRBMG/HqRZy92XCc87p3FRw0+k7gCF1KXjEu0ZWcbVG7CqDAb9lMkcjHK2pJOVscCOv7JaIrIaJ6CK/smCqvSaNZIF48uJL+YYVZ/WZfaxo6TGoVMrGumKLxjqdj0+lORWeKTIYfKRFZTph8dTJBgNio2d2jGtiGSx2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBT8VAeD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBT8VAeD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2824ddc2so7653346d6.1
        for <mptcp@lists.linux.dev>; Thu, 26 Sep 2024 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727359569; x=1727964369; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKCLtMQXzuzRMyl0G0TZx21yCW+WWi9kfwInBGsxPBI=;
        b=BBT8VAeDUyjnt628AAPtgOVUbdPipqqMEXM7iaHvB5J3H6y6cz0LQMuiy8TmIbfysT
         RgeScU1Q/adQTpJMGi9Pvlj1YbPgMptwumYxfdor/ReLSEUsbE2wRxu9sVsW8uFGufGk
         6ZKWVMDMiJBHFPeQAGe/6IHSCdnMgJTvrEwVrNhs+fotEqDsPLkLYI8WP1t02Sk8iHW2
         EH31CLoi/N13E1Y8tvLLiylD9ceYFrDOFGcXC/MM4RmUYAlQ9YG9rggwZQIOQ9Am+eV9
         cztyCb0qWMKSK7d7vL1gw0hTD2EIFsHPy/qOWxmDknDWLCQvHNAwQP/rgog5t6Yp+L5b
         4Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727359569; x=1727964369;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dKCLtMQXzuzRMyl0G0TZx21yCW+WWi9kfwInBGsxPBI=;
        b=iP0MuHd+H//A/a1CA/rF+iWhcjUN0R9sF1RWhH2/JFzblqghj9Pn3DgamQgxyPwA2A
         uVMRuG91OSNs1S2f5v4Uindo6ZUpC3Au/IeFVgw9kEFX8c4fu/de0T+wstMcWmew9XDv
         bARnIBGOGJwQyYGMOyTuoc9CFoqrvCNHk8hH/d3KRG6w4WgW2/SkomKB5QW4PqiSC8FX
         p4sXp6N19iwlRyu5Ui5i1QLxn3bo1hHJnm7SCyY2V7V518FquQaBDqieZVhPoDQ0uE/V
         nhePD4lVHUfkLJdxt9lmX+oBrIRkp9Qy4v4f74ewG5XK4FLlQ71OGzOLiSc7SatYmDR6
         8MiA==
X-Gm-Message-State: AOJu0Yy9W8ANaeoKx9y/MLHu/J5U25cEzItMcjF9rwP0AzDrNAS8dtO2
	2xAgDoQ0DqeVFFFyLnzi9/e4Mx1wt6tZ4FIWSk2tk/xwJFsh874=
X-Google-Smtp-Source: AGHT+IFafh08hG4uxrbZGL9ItX1mhvGlAhJoxjt3badDNGVcnWJ3hHotdD/hjcsC46RXJaS2+Xi26Q==
X-Received: by 2002:a05:6214:5d91:b0:6cb:3723:6b7e with SMTP id 6a1803df08f44-6cb37236c49mr25434306d6.37.1727359569079;
        Thu, 26 Sep 2024 07:06:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4e9e28sm26093146d6.74.2024.09.26.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:06:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bb54c97dcc2b2d4ca80d03127b9b0e9a610929a8.1727254866.git.pabeni@redhat.com>
References:
 <bb54c97dcc2b2d4ca80d03127b9b0e9a610929a8.1727254866.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] tcp: fix mptcp DSS corruption due to
 large pmtu xmit.
Message-ID: <8e20fd51-33f8-a012-b4d2-46b19b303f91@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Sep 2024 14:06:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11053001689

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d3444ddff14c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D892713


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
