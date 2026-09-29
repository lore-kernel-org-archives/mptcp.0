Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F03A1A3F
	for <mptcp@lists.linux.dev>; Tue, 29 Sep 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667062; cv=pass; b=CqxYWYpi4+JIJssOLgma+cx+JdRdd59KbF6y/OaoJ3l9IocERvRWYXYAp28w6Bzo1gjhUUXLDurKKlZDZgWsFxbKqAuo8DvW1yW9qq/gnVmjcdQ2qPj4Mpvcn+9UWMlEPH9+avOK5vZJ/3CGOQNSxIHwJRS0oAUkZWJVXyJlR68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667062; c=relaxed/simple;
	bh=I35gDNGA4fpIsc0ElTO4/D3swmmdD1nD0eRHXQrQQRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdCLs9cXEv+UzgA2SgFG+36xpBTTnF6/P1hSb5ADKENo2vAmySKGTCa9IWbaLIscaZ/YzQWytnZCSPCGLnhrluxQr8pNU13tFbmOCdAJquG4KrUO1+LVinvAfN8tGgTTDQ1gD53m8hx7sxWhLccW9Gh53yZbK2WNAdPLuDuR8hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdTuAoE3; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdTuAoE3"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530e28a62abso59418091cf.1
        for <mptcp@lists.linux.dev>; Tue, 29 Sep 2026 00:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790667059; cv=none;
        d=google.com; s=arc-20260327;
        b=NP3yINPkK+za/blcbJJ866rpj5Vc0mhFjxNkZVgflRWeTEJ4+jJcQMhChAEYmVQceE
         GMm6IaCbtId4Pk3KJptcnix4CHvKctCGG5AzqNzak8BBfUG91BfBUF4kTKAi752KP90W
         hGbqSRWW6mChqrnX7S2bNBGSzp6U71L5zxu+BHIh/YtysLSBeWgAmA0OUOsn0YiPMdil
         sxSu53WR00Kt96+AHcCyXMkEd/xZrh3keoPrvJ7w4dH/hDi/lSRxZ4l0m6f9omBxQwXi
         6hQ9sOXYlFqPyRGK/hJH1fKmnGO6XR+nig/o82edePVvkwlPz8wY6HFmdiJ0r7r4mfMa
         5Z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        fh=+eXL4ooB7MCNrnbfyd0oFjgxrMDx14auCqKtr2fRxcQ=;
        b=ise6+NjLEMEgC7TzlE778hYJSf+0jsqLA6vnWzpZfmymxlbYvlK7UadiDn6Txz+oZ2
         uQhoGnaNM8MyDLTkmRXqYIoi5m411DGhiudGJxtJOMT7z/SPv/UxinOGt65cPzXxt4w8
         XWCN0+DAQOSG8lxDAiZ0jEl5kHWM8DYbcff8gLybaZ1nPER+rZhqKTOrNfMHGvz0M5h2
         l1UnxiSWeRw2fcGoc3V+4JWsFSk1DWkbznTEgJ506sI4JjtgHoBUO2vCtiBse9Xx6Iga
         KtlMU8dg8lKoQz/5sAtg6PZ4pmzn065arrxoNZzrLYBEbXGrUo163C0zal+AxYVFUFDx
         Bniw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790667059; x=1791271859; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=pdTuAoE3TBwXW3sfvj8C82vM5pqQuiIimdCNzsV2silb+tvySOMcffTVKxyVyESx+v
         W1UUxlCkv1pvluoTgvrCgaCS0CLifQuMnMY+72pIs/lYQdNFocOVHVPEW1h/GAWGHOQ4
         cDJ3quvWjAOJYFwN8s0r8bGALYwnWb7TtYKN8Vg7GFu6VFT2MCEx7bUS/vZNHXjCH7jA
         UR+HQCmdbi1TYZcZq+Awn3+vdreDD0fAdebBxJ+aVgUfMkhxT7NIV5jndDcWLz24CnPA
         Gdz4PIUDayzeAs5S6g9leK6HbxOqnp1WwVznXegWUO2iohZliy+CV/3bA1qWh/A5qH/8
         9IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667059; x=1791271859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=CGlq6SEoQxdHroC52QmdiurCa8zRlmBc0iV+gxEbmB0dtStWj/tu0KNTd/J1U70ijC
         86zda3deTiHmCWLnTsIstNKHR0TTXf3lLiGf8XPi3nhoURLP3tif24oMGtYohuJ+YMOq
         STzKn1dX/E3n7gHkvJxmasEws4yvonP0tGfHuR4FI3wZEpbI/hlp+aIPxs6ILKvGasS0
         Fi9hDc0CcAhjwwaIJndb7DEzK1DYvtE2uxRipOlhy5Xja5ONsbgJEvjX953NJXlF6sZR
         BbnUJlVBSbx3CQjz4zuI/FrZFfEUBXc7i/+ar7G2w/lstR+HzZ4rMtwZYYLkc0eFlZ4T
         xZBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx61mLAmIef4S2og15HxCA6zA06fry6QfMAGEb+Wu6krRAwvg80SnLDqGe7Ca3yIFLetQP59Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mwL3NeLz3jj6/TU0x4T2fS8NCZkjCVQHKbMeGRlAwsfv+br3xx
	zKSkkva9/qjmMQuqn3OnLmwGq3iGewkye4NDJkpivSO9SIpCmiWfmWha0jWcFcghMwakNsY+R3z
	OI4pSOYkUT862P82i27UhqilWpSM/pSm6Dpp3F1D8
X-Gm-Gg: AYBFou029EYByRQVvfc39P+sE/XWMrQaFuIFKqi0r5i0x/2yRfKBGo2HwBlzq5kvttH
	qrVheZk56AVUPJVOOa8JA6OCYaCPWRF0c02a+E8VDM1Nvd8MDDtabP8jXv+C5AULNtrwECKbrLK
	mfdS4EJUvkOAoNdQxrzxfRatkX0CKIh+oUBfqj4r1mC4pHNaeNNClqtNtwVk3xrHxDnqDUwcibu
	Is9O5vPHXLldtVon5QkTb3lFza2d/F2R7QPhu4PeW/k+2zixzMePAkprhFhq9S8aUNe1egRyFfV
	0j2SEt40JTDq4C9etS0McHCqUU8IODUubzvryVGvobe8xFOGD6m9IiLYFTKNkHr3QpD6FrRoW9K
	ZROH5SVIyLz1/dCjdydcc8Lu8CmXLP2GNiQHu601miFzOWXnvJfBQZKas4PwwTebdPg3J
X-Received: by 2002:a05:622a:580a:b0:532:d3c2:165c with SMTP id
 d75a77b69052e-5330dbe7682mr252226541cf.5.1790667058017; Tue, 29 Sep 2026
 00:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929071743.23624-1-edumazet@kernel.org> <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <179066667444.31693.3326934466907750947@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 09:30:46 +0200
X-Gm-Features: AclHuK9CAnCUx8smImHilXsTcocuUN-fbbX48CMDJnYU9QbhFatMhZFb2tpvc_0
Message-ID: <CANn89iLUKHZVrUOEtqDwuAghCRAkddigPwSWj4uS=fKyWdk86g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

Patch 1/9 fixes a bug found by code inspection.

Other patches are not bug fixes.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
