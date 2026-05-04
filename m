Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1713A783D
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892828; cv=none; b=qgGA7OrVgoYu9sx53SSdYL+ausbddRoRbxCi9yrmcmohIfDa5ikf0a5rcJgJZsdXvVQuw1M6e4KMCvV7wm0H7klE1uORtx79kI8yH2MFsYleMCIMA1rUlevI3XHZCW4W3g2Bkgj5Epf1MUbNRIk92bZNmsHBmbP3OFO1SAdEWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892828; c=relaxed/simple;
	bh=wLc+6W7oF+V+6d+XYqbPkPDWemjXztqb7lr09d4IZx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=i2QZlAVPD8Ms5+d9DCOG87ob3jpMQLEqc+9LabZ7SfJJApYCBJntEsnw/L9BrT5HhLf83yB0YtgB1yzVS69m3IGM+ThfzV4NQ6NAWDrSLFLd3eRGTz7e61CTAMHhrd68d1036DIv+YOXaN+TEZ1MNpZ4fefXsqQvEcTlb5KRZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bolnyYW7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bolnyYW7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fc496c8baso36291441cf.3
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777892826; x=1778497626; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+vTV5IbPCB3ROxvRYhU/EYNWa71j2M08mkLOvpsoi0=;
        b=bolnyYW7lQVS9M0rzXSwVc5mfGfV2xw5nlEllmlrGDcFcLm3V/I5t/dOLlXSWuL1Ds
         qy6J1QfivjPJoJSv1fNYAT8ISLBOsdRHsvfIJRekfkrEOIj/PMInFMUgl+NbyHQjJV8w
         I6qTKst5wNZET1yHJHXxoB0c5l7fPXtPZlefdil3/O4cY7525f1O9Tidy2p31jPNC1Os
         cpJvGB4KR9v93bZagMXwuYK7Nz9zWdatqBk3NEbU7hlWaksKHXm23/Odgx0rf+RWb0Jb
         GJQhcR9BoA2QkwD124D5UTj/zBRs1N6Q6yM6+xbXEuHxqTvm2tz1XB0YNt2OyKkyOCdO
         amQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777892826; x=1778497626;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+vTV5IbPCB3ROxvRYhU/EYNWa71j2M08mkLOvpsoi0=;
        b=YZhOFhhyQFPrWEs4W+QJlh8xX8oyYO+N9EsGQBFH1UypiCn++9cd24qqbq+vpISnqp
         6i5T3pULsst9ZdPb0lgYIV0qJ49stIoxG4hbYtfILKAzlaszti3IG/MU+sFn7Y3EszoR
         DTL+2qeL7ddQKGPcRW19S6WYIikj+nkpJwKj2ndB4drRFY19nZsMIxhF3706cNafvFUa
         EsZWhrT0jwxSKAD2e7MhQBo461ENUXpxVi3+a36GvOj1/i/2xBBVHWkOkr5Ks9AZCRtT
         uzTgGU7BzzERvuSn9sRw2SJMnWctZMWX747DywrFxXHYSqnb5JwJdDVoKL8EBqd1B6SF
         ljsQ==
X-Gm-Message-State: AOJu0YxblYkpX1C4Mq10J3mXGqjZ/OUJUpXHZYZl6cCcaEgiqU/znIUQ
	ARzHxcNEiMpd6+MjoPIw41rGpSu22RMt9lO4P0eo6DWV6mZYsXr/yNM=
X-Gm-Gg: AeBDievcNAfEW4JKbFL64CZ6cre9+tlFNKoAC7kxcRn04P0M8UAzXnnOKoUjExQUHcY
	1fcSs0DlRMblI7i0/AELBZYaPeF1zizv+sXFTRQf8/CvuNXsVbJvQ7VJ/L/dH68joRyxXtPVBVX
	i9UUQoKCjhMyhiqSbBnSvL/MpAkTi3EWHYDhEQnoAl/U+3KWqebeewa7jW96l6wAUJ2mM7ui0hc
	RgedInwPgrcGgEFI4zcF96mjo8xeUYvrbGQ4Nza7d4pwyDzMyZ7asg+P2pS6avBQ6RPsqeOXrCr
	d5RFQJp6jKhKmqfKjICF9SViiVARlv1PMsIL9ZLJqV90OsiF2shlNG2GxgAknZ0KKOKHcjQTV+2
	/180sku9lNsmslzSkshSMWRGawdoH+DGH72FToxTkq8OuvkIvDK0F7pUwjL93Eiz5A0EWq9Rx9d
	wxuEQqynofJjwRILwmm2b09o6b/USnV0tNiZba5UBNu1o0mVDTgfneekle
X-Received: by 2002:a05:622a:1791:b0:50f:b494:7887 with SMTP id d75a77b69052e-5104bf42a78mr134479931cf.51.1777892825753;
        Mon, 04 May 2026 04:07:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.158.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b35795sm93622821cf.16.2026.05.04.04.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:07:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777756707.git.devnexen@gmail.com>
References: <cover.1777756707.git.devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v5 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <078ed489-f90e-2010-db97-08a89ebd7d5a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 11:07:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25313259921

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e3c0e270017
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1088853


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
