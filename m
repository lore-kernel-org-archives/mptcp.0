Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C92737E1
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152818; cv=none; b=HnIu4pFRFediDqkXS9YKxLjTC7fHon8EF2dC96v5V6qWmNKDI4P26Xzb6DL7xYpHlWjI6DqdJxkuJS8DgX/dY7X9diCEdmMP5fzJt3zEZEqj4fCFxdOJqOWWQaglGjlI5drJKUJcqgZGbISKnPS75u96leXrABTSPyv97Qx9Jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152818; c=relaxed/simple;
	bh=VH/G0c4QxyHu361KPwLMEp5dAEmq2F5Ui1BgioRWhtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcPbkhQY2iVMPhQ8DW3srw/JE0YHDs3qfnffvVgldUIov4OZMysHXHtiQopgCyuDTjcZF9gtWeZChDd+8noSGZ+DTSLRvbp7CEWfEJoRPXDPJ4f6+oRhfnyGaEiZgzst9EV4JIaEnOMF0XG4Tc7JxCDr2p2IsmPE1HSEEAKin0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vHquz7Po; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vHquz7Po"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87dcb1dd50cso95419796d6.3
        for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761152816; x=1761757616; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCzgcuEp7CAzGR7HOOdsOQiZ4DRoGV9cgPFzNpkV3rQ=;
        b=vHquz7PoxtX07oFFv4o+Ye4aMMe+MmIBp3Pn7UqFZbiXw2Ae+APEVrIcFng5EqyghI
         FWT80B8T6eesJgJsyQ1hwRjX1iJ8ortmrT9I43Z0Qgh1GXrn1agCNxVJFNbiOdRQItP4
         gHs/Kl40ucV7k5URbbYZs1nuP3uvY8zvp/AXQPPiYplbHU0H68svEl7PvSSQdj5nv1wf
         HRe++u11zkUQG+62q8f6aPf5TP95X5HPnr8A0YReUqqfWicnBVAdAafkEef0YmoA5oVU
         eCnbBwnF5ZzdGqFWuRCEevULnHFy0dEl/o4XqiIbKF0Uz406u+eD7ufW/XnENf0Svaxb
         g2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152816; x=1761757616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCzgcuEp7CAzGR7HOOdsOQiZ4DRoGV9cgPFzNpkV3rQ=;
        b=fOntJob3vTfnEA6I7cBvMIpr/FHOGk7iQJZyOt8Q+nYBYj5ae4Vj0Snp74GyqDn8v3
         p6LyXXwEOsZAMv0/gAy0p64m89s93cKTdN3HTjWa8mXrgK4V3qcCLXDjLIIrc/bVamdL
         LmX41pR5i3YHgOwOVzak1dwUzhxE4HYy/U9b5lB6hc0qGER3qgltbj3pnmMKL7vpCBqo
         vGd8e7uowi+8CLmQlGcZQQ7L9U0BE33lo81UFz7DGVneBdGqxc0Whw6fU1yYbFcX3GnL
         DM0AJ/ir7S7/KdNNQnVZJGcb7OH9LsB/B8JqoSxRWVqByY+sUXypx5tEU1aFeyOW8qyi
         KUTA==
X-Forwarded-Encrypted: i=1; AJvYcCWRplM/UIjoMpv2eRu06Th5D8r/9GNFzkyYHv3a6zP0j+NLjs3dKOi0Jdj3+WqATiwTlir3DA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyec+XWx4YdCTxTEmm6ZXlzNBbCbNr0Ph7BveSkstLxfQzblR3V
	wsjT+NREzmSWkcZzKH//9+bSW4dAJAIbSstptPm/GCmLaFPjmxFZ0C2S6yMJ/7jr6kY=
X-Gm-Gg: ASbGncvkt+fphV4ASeiT8Uigar9RNY9oI+2R1DYTuFTu5VfgE6xaA3Z6U4ZKzotf2iQ
	EzJoIuyVCYRvWwYKDVRd+V4iws3YWfqNogGoEFa0/ID7HnDV12KTWcAWnySmQ8Tvd5JJM4aU2pC
	2Btx20bhVZ372RtxNUI7zp2pMSOFlVS9NKGNWMX1IrT9eDLGL7YdbIuBoqQo7XeFuYrprHNvHOD
	Q1/6hLtAYgWzG8jbtYyX7dSnejZxCiVnKnvmAVN8TVXQT+ChnsELxHUforrUxyULdEZ2v76D2D0
	N2WtJrlyYn7ERUvBflEEyN+Rw4G+ib142HgaUjc5lyt8JXHMjgVIXkP8vXal/VNY9ZUk4qOTsZ9
	jLmvt1GOOCryDj+uAqCzeYuITuGcXp8cWJmoxd7ucZy1B7Th76w6/Wzo4x2GKlmOC63SXpp1N09
	/PT8BJ2oB0+38BL/eGGTNAuXqoJn3wgSyZDnMJ/jEQYIA1mVlKdw==
X-Google-Smtp-Source: AGHT+IGdWbYTC9vzHNEAyIcGDx0IUkeY3uAeA6cyKPnhJbJb50wH1hNHVbvM7ZjgflV7wWsYLpjhuA==
X-Received: by 2002:a05:6214:e81:b0:87d:f2ea:674b with SMTP id 6a1803df08f44-87df2ea69b1mr81407816d6.58.1761152815577;
        Wed, 22 Oct 2025 10:06:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fd099sm91187006d6.5.2025.10.22.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:06:55 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:06:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Andrea Claudi <aclaudi@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH iproute2-next] mptcp: add implicit flag to the 'ip
 mptcp' inline help
Message-ID: <20251022100652.6d24c0fe@phoenix.lan>
In-Reply-To: <946ceea8-eb58-4140-aa5a-94605cd697ce@kernel.org>
References: <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
	<946ceea8-eb58-4140-aa5a-94605cd697ce@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 16:49:41 +0200
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Andrea,
> 
> Sorry, I'm reacting a bit too late here (but Stephen applied the patch
> very quickly :) ).
> 
> On 21/10/2025 21:26, Andrea Claudi wrote:
> > ip mptcp supports the implicit flag since commit 3a2535a41854 ("mptcp:
> > add support for implicit flag"), however this flag is not listed in the
> > command inline help.
> > 
> > Add the implicit flag to the inline help.  
> 
> I would rather not: as written in the man page (by you in the mentioned
> commit :) ) "Implicit endpoints cannot be created from user-space". Such
> endpoints can be created by the MPTCP in-kernel path-manager in some
> circumstances, but if the user-space cannot set the flag, then probably
> better not to add it in the command inline help, no?
> 
> If someone tries to create an "implicit" endpoint, the kernel will
> reject this request, see:
> 
> https://elixir.bootlin.com/linux/v6.17/source/net/mptcp/pm_kernel.c#L813
> 
> I can send a revert. I have other small changes to send.

Thanks I reverted it
