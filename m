Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0C4B8DF1
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578334; cv=pass; b=OI9GMXIK4ehnUYVM7NUp6aLRX4ybyeXD/WpiMmrqJgxzHPRyeljMSK5FziZy2gkWD2hfERBfSAcJJZYu0J7fEFKK31/VOWInwPVbOlQp19Db3QWq1y/coRnEj1JdCC1yRU8VVYnZVRzJzzEbvixqObuzJ8txZ+pg6Rln7BzXuJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578334; c=relaxed/simple;
	bh=wUiZEKGGfBv6xOHsW9yd2mGB29/lS+EetheTvWe7K3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9Cmld6w9g/G6TEuzxCRGVjSZnpqxLTi/1HwgLpjnLCU8uMtJ/Wi4w4DivzrXybBetXIkLRHwMpR7P0HI57hF50JbHhRvWMuhxy8Q4KlJzThabkS9E4vPl3vpbdR88nYyffZsfrU+hLoltDzC/GL4QwB9hjLeHvppLOZF6HU/CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DE6tEA+2; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DE6tEA+2"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso48066196d6.2
        for <mptcp@lists.linux.dev>; Tue, 12 May 2026 02:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778578330; cv=none;
        d=google.com; s=arc-20240605;
        b=OmriG12dZeNKwrw9z8jeBN7s0gne18nFUcomkhEAD1w2GUeq1yMNXR0mbFHEdfE7S/
         LBCIhsAMsWH7qXcahR21c26EpP6JxeL+gsoi7NJcHCMyp8B0uY+fQ8sxYVcUtYNcbyT+
         CknlQbnzDf2KfCm5lfNFwULiZBcMuD+oNkHcidyA48x9DaEtLQZJQIJHcf13kjHwfXXH
         j520L4lpH86jqaYLJCuEhTCyghhuzyajjmsOA0BA//UF+lUvcKNXfGE1Y4Zk3hxNVMLV
         WyUHJeRgSV4GYPk58MuPr4+5mfHF5hY7ZeXF3gTADtiwe4vINd8H7+IUo0DONN7PG2za
         PzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wUiZEKGGfBv6xOHsW9yd2mGB29/lS+EetheTvWe7K3E=;
        fh=FVFzagSAg+pWg0qpEqvbHf+Qi04/GMJqw0x2cGSzrU8=;
        b=aHvNx+rs2cJg1GCLNSFnOH+RZ+tpeb0NI9Wa29V/pt4Yvx0utT/evhgwtNwwdZywEo
         j48YYn5Op/S8VWP3cRGhDzYqe6HxsucM3xOZYS9kWclwEiG5oz7M/kvvAKlMfkEJSDiE
         6G1valube6q1c4JmEJc5pK+ls48VB5hmYMDCYXJoUyHjKqO2gZKx+9atigu+0zYeTkto
         CIFdtaW5W7j5XuhUtqRRnV1iOAVHnDSv4I8qjSBpAoyRj8waML0bEjdhSbOVwIHqlodr
         e1qtUdged6L+e8b+r0bhcZX/fLaZkoO9j5nSb8twdIK1UQVGxXtRKRzYg82sdZnF1Rxe
         Vguw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778578330; x=1779183130; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wUiZEKGGfBv6xOHsW9yd2mGB29/lS+EetheTvWe7K3E=;
        b=DE6tEA+2hTyGTiLk6b5QSUhprWilCnLTlN+5A/LP2b54splTSg1564xXZKDBuFPZeI
         zZROWs6PXb2gk9bPO7iyIZ6u+fuBXcvIxncXiB4ZEWKAb2lYOcmy/2D1pOKfSjNhm9zk
         Lr9q3klYI+SJRl5mL2Izu0HtVqr8PxNgrgMTp0hmDP4YlpYTmwVEi84x7G1zjMcUnUki
         wd6+UHfRBbBpp/Z0sgV4FFXw9ofv3cmnmw3vxwKN7wxpo5O/D+17vqeJomynfw6dZ7Mp
         icIdUsTTBG4saD2VvtetK7gZPfPCmk2B7iCggbQsGXlq8FY7L+ratKihdpibynE/rVx4
         R0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578330; x=1779183130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUiZEKGGfBv6xOHsW9yd2mGB29/lS+EetheTvWe7K3E=;
        b=A5DasUySk8y1MKRx0KXaqvRGEt0Oo5h3WMws+ShRWJsIbm8ekpc8/ttAS8ZRkg0TAY
         +1RsxoYN0WZ8j02q6UHA/dqBEUqw7tP49ZmyceM1E0a3Em/G8mwUM30IHTwmG/F3gITi
         xZjGDWfX/PTymK6jYBQoSKjnzuSzCi0lZ7AFW8i5tpb1dPGMC8iLiED2U+YHoA28guGH
         q087udIwqh2AuaKwVwPfONvVc2C8eIa+ahjGkt73opkGhdPzAuAJdgq8Qrkb+Bq/cBKI
         ez3lmsuH6UIN/xkBASJrxkEZi1eEecDUYlfEWfs4SCZrcWaLBOkMe84TZXJFDtT3odX3
         jdGg==
X-Forwarded-Encrypted: i=1; AFNElJ//GWxTBn1cC7QfshjlnRjCQV7LI+AFmeW3i36GA/O+8wuRUBHxvMRUNhRgQszeoGAxHUqIdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCtkLbNNk0cWsssuK+kFz9++gIxkD5MWraRy+J7bsqhqyk5sU8
	DjGXRhL4v3dZJgFRjj22IakuI9QMi8BPLjFRVZ8R/FZXKcvDMl5ZxWpRodu7M4/dPHgbUlqtZ36
	562nOqphH9iGoth890CRvZLaiUuXwaN+wNvNQkSGd
X-Gm-Gg: Acq92OF9HssYHDa0/pEHb2D8GU0zimAg8iIzQWJV+5KP82vYoXFl6SXybCJaRvK1BkR
	2DyR37T4X3OPVqw/mz6Mo5rEaxiw2JNwW5SnUcnYN7cSp54vG6OmdIjmx1MnFcpt2QvGxh0am4n
	aiFUEFZQtC7uZqh00xkL3AYYlLwbRYiUfwhMCNnkmZc/+Hz/Y+Wx7CVXeCj2MQOW+X3p4CVtlbq
	/5ti+fvPZf7ljcCn6SC1ijHt3HajiaMvo8/HaZpoDeA/wAYwQSDeSBQg8sC7eUlcGYOAaK7QFjc
	2eWWpZkdavpIhUn2EMSDae2Tvl40F/8A1tmiZz7oxqFVIexg
X-Received: by 2002:a05:6214:2f11:b0:8be:7ed5:477b with SMTP id
 6a1803df08f44-8be7ed549famr341525756d6.22.1778578329364; Tue, 12 May 2026
 02:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <69f8e352.170a0220.bb392.0005.GAE@google.com> <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com> <CAG_fn=Ud-sXzebnwvsiwnu6e0uOHRAFzmUH91Du9pek7Fsx5bA@mail.gmail.com>
 <43a84c8c-0d65-400e-b735-76210af4cddb@kernel.org> <88d94464-9391-49f4-848f-f359b09b0500@kernel.org>
In-Reply-To: <88d94464-9391-49f4-848f-f359b09b0500@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 12 May 2026 11:31:31 +0200
X-Gm-Features: AVHnY4IOrVxDGYQ4vYi5rQd3-ddeK_kK0sCusaAX8iyMl0cEMNzC96RE_NjdxIU
Message-ID: <CAG_fn=Wq87q5wGZt6_c_jutS1yKC+Yv1CsOOfcO03pZBVWzTdg@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, kuniyu@google.com, 
	syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> >>>> Plus I'm not exactly sure to understand the issue here: mp_opt is
> >>>> defined and used only in mptcp_incoming_options(), and I don't see
> >>>> anything using it after the end of this function. Or did I miss something?
> >>>
> >>> I also had hard time understanding the backtrace, I think some frames
> >>> are omitted/missing (it happens sometime, IDK why), specifically the one
> >>> related to mptcp_options_received() - which would be useful to
> >>> understand the issue.
> >>
> >> This is probably related to
> >> https://lore.kernel.org/all/69e7ee1f.a00a0220.17a17.001d.GAE@google.com/T/
> >
> > Ah yes, it looks similar.
> >
> >> Let me send the patch, perhaps this issue will also go away.
> >
> > That would be great, thank you!
>
> Thank you for having sent your patch.
>
> Here is one combining your modifications, and the ones from Paolo, for
> syzbot. If this one is OK, we can continue with Paolo's patch.


Hi Matt,

Unfortunately my approach was wrong: see tglx's response there.
Hope we'll figure something out (__no_kmsan_checks looks promising)

Alex
