Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856039ADE
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150105; cv=none; b=Ab3DFkI0I0pjnphib0rgAC1l/55k/VEremoIcKjYs/NGY5neJQJj7TCGau5skWF4Qdmc1kzx2B2f1RElJ5PwiHhziSlt7OxBO660ScdE/K3e4e/2prY94bbPMCMJQUPkgrBqyF9NTuwPQHofHCUjH+3/V2GZl9k4CYo/GW369rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150105; c=relaxed/simple;
	bh=gSm0+dMHd7Lyvy8GwJPQavZvVWa0H+DWYqMpERKqQQ8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P499PI08+0fPf9bTqN2RLr+33HoDG5JGKErcRyfebYsbm/dYMPqaFvdT2uqsplKUrM13OhMz/E47OGZAakBvtLX5YW6g8AOeSXziEMAXkD2/gPimn1tjo+x0gcGy8T8J8O9nZ16xuh7Mb1qKCeWXPS14pIV+k1Ck3Wep2XUlu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUU2E1MZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUU2E1MZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707150102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XCLWty0DVE2Ux6Y3C9RPsMJjwVXySF8wwAd+YMCj4FE=;
	b=HUU2E1MZZPnrv5RYzYT6rQ94i1GkLaxlqSedRGUySPIXHw9mUZaDj8+ANpMO6/Z9m3tq8V
	iJbEf8r+BY9owcJQKOHN8SGrJ1n/T/jbn5JZ85799dHB2It1I7sxY3IpI+xJgR/8UniPFZ
	5yfdzXwacK/XNsY/4Toe365oRmsreYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-UPKkZltnMiyrCQVtTfSFMA-1; Mon, 05 Feb 2024 11:21:41 -0500
X-MC-Unique: UPKkZltnMiyrCQVtTfSFMA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fb45c865dso9764425e9.0
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 08:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150100; x=1707754900;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCLWty0DVE2Ux6Y3C9RPsMJjwVXySF8wwAd+YMCj4FE=;
        b=STXhvQdRH/f06IOSirvI6KU/jAM3tc5U2PVF/SNR+RYi3fvufgAIqoZnr9MdXBqN8q
         giyeXK4IV4ur5cSH1SuHHxuvagnGHXM/Z8dLkRUbA+dm/akoEnnooUhuOJr2KvxQv7pP
         AVb1iytrBChviot7CeiH2eGkgQs6XvMH7g8pi1hfQ00eG++5vDD2tnQSrQaU92oYXBYI
         MW5wqURa+AP3KrZX3fGd9nrjG00DqpnIyTTs51U0qxH0PJTrU9r/NulWSRhSgxGCihMk
         nEliTvhbdQC2vn+rxqZWiifpD3GL8XDNIRD2Njz3ro/ryoQ34HC7tFJnZA5RR63pxegV
         IUzQ==
X-Gm-Message-State: AOJu0YxZBDBwpqKac1AM3WmQXguPSkq9Uu2JyROLO5r3u+E7n1+YOS9i
	CXR2BsQiK2KFkliDU+xFHmUHCh5EUWZEHKYf5iSOng8Cz3yt+wmKUJBjZRU+x8liGVnx0w3jGfE
	/KAD0Da2Lpmx+aMHlKiHokRDjFjLEPVZMZv+XlRmCKxuG1tj+/1F3
X-Received: by 2002:a5d:4dce:0:b0:33a:fc78:55a2 with SMTP id f14-20020a5d4dce000000b0033afc7855a2mr30769wru.0.1707150100149;
        Mon, 05 Feb 2024 08:21:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFZrMc9UgMapO3qXLZx0PBLA16ITx4m6HOdaOFXS1tqhVVOf592MUyJeIdAzugi3kyJCVUgg==
X-Received: by 2002:a5d:4dce:0:b0:33a:fc78:55a2 with SMTP id f14-20020a5d4dce000000b0033afc7855a2mr30703wru.0.1707150097978;
        Mon, 05 Feb 2024 08:21:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfZAflW0R+dph8YC9I7mmGDrQo5SrQDtvUyrpCKWWHfu62PfUI6iGZmsBJYPlSL54bzwlMtaK/jBn5NPIJGuCMmsrMhLt0PCD3V4CIvul12NNu+risGXZguhK/jZ2MIjgib+deOGVn1QN9aVcH2h+3O7SJUS42lnAnqlYlrH8jh09oKUsvE2DuCjzqwb3+i7+f+FIgQtV7S4HID8zD8ooEgKt7yT5VgoaY8tWEo5/g85/XW6wAcR6avIRP9TNeFsZ0SueVPb2oWJCq+txTj2v+KnbmCm6Dmudf6j9xfFOvVInp811FoRH+m03K++YvnShd+U+Jvp1oc3KAdocVHdY9BrcwOoOhl7T54g7FKRKAZ6psmMOxmwdKnBUYK6mEfvo7idtttzQaUHyan2vA6E/0
Received: from gerbillo.redhat.com (146-241-230-60.dyn.eolo.it. [146.241.230.60])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d54cf000000b0033b35da3842sm4003061wrv.28.2024.02.05.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:21:37 -0800 (PST)
Message-ID: <e4154971623ec3cfd3b500e0ba1e09301d5fcbb0.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready (2)
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+732ab7be796ec0d104ac@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, geliang.tang@linux.dev, 
	geliang.tang@suse.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Mon, 05 Feb 2024 17:21:36 +0100
In-Reply-To: <000000000000e8ecae060fae7a47@google.com>
References: <000000000000e8ecae060fae7a47@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-01-24 at 02:25 -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    6613476e225e Linux 6.8-rc1
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1200cf0de8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df9804db253bdf=
c61
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D732ab7be796ec0d=
104ac
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D111fe2bfe80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17abc23be8000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cdad5c52fcde/dis=
k-6613476e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/14491fee3433/vmlinu=
x-6613476e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/953a5864daf4/b=
zImage-6613476e.xz
>=20
> The issue was bisected to:
>=20
> commit 14c56686a64c65ba716ff48f1f4b19c85f4cb2a9
> Author: Geliang Tang <geliang.tang@suse.com>
> Date:   Wed Oct 18 18:23:55 2023 +0000
>=20
>     mptcp: avoid sending RST when closing the initial subflow
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D159a9427e8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D179a9427e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D139a9427e8000=
0
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+732ab7be796ec0d104ac@syzkaller.appspotmail.com
> Fixes: 14c56686a64c ("mptcp: avoid sending RST when closing the initial s=
ubflow")

I forgot to mention this is looks like a legit mptcp-related issue.

There is a fix for this in the mptcp devel branch that should land here
somewhat soonish.

Cheers,

Paolo

