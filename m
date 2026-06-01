Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02927A47F
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304654; cv=none; b=D3HX2MfzZwKjJKc9ZSz6+s2FtDE5LbKsLo4v7itLZfSWqIvqGZcW98Id/1k0V8Oi4S3o/BebgFmK9QVeRuGnnuIBCOWPi33PKOAg45Aw2VfvwCr7CLNyZ0JUunf5DCLYo7KI0Wrcqquh3ET83pS9Qg4OmH9FMtOZ6bnTmIFHXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304654; c=relaxed/simple;
	bh=h7UzXCN3auhPK5fYRx7iwupsGeyo7bWhM6VYPG4n7Jo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rESZDwmKG9eJpN9bYOvssGkEoPKrKcNlbj0CKr4XnMK+xxlBsOCbSQUX/vCYW39G6HzKq6y51sfUOvBoRsQXDdAnjThq+h4Je11UT+w8IxnB3f/QtG2cy5kWPb1/Jm2KEIfs+KwTy1/9qbQorGSl9O2hTQoQ9KXHRpZpIvMEbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+Gp2iRW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Gp2iRW"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91550eced6bso141600285a.1
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780304652; x=1780909452; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftBl+EeHQnzpD9DBXCnqPDJmvCcvlJx/hwEBW6vPoYM=;
        b=S+Gp2iRWjX52b+GLe5wS5ZUIjn63VRMCucLWMy0KZXsRi2IegX+1X5tq0GQHftQqL5
         VPEys5HzaIXn6RbD0ucVwhH8+dto+kObBiBhmKrQMkb70mfTVhWAv4TXIwalR4nvPm3w
         t+PqQIogE7AqRFrtDxduUya51LKC9C4cZjWlCcgFk0001XnAS0aYK6z/BBeP0g9Zjuqo
         VNOksRlsM/NSI9a059HdIWr+YOb5BSMIMZ/B2Eh+yJG5EdGiGAAPOIOYX01Xs/t8j7rv
         84UaN1UPZwm4EglLCYgwwtWaNk0z3uA/+V9XXpbbpLhIswWbiQamz8vPVVkx3RhFbbjq
         TRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780304652; x=1780909452;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftBl+EeHQnzpD9DBXCnqPDJmvCcvlJx/hwEBW6vPoYM=;
        b=XJK1CtMIHfCPoW2MkYFooa/mg3tQYpKY2K+Rzwzm0qGCxLeGG+JsrxvUiUviUdLCn3
         kEHfKRpeW3WzjsbhJFNauM11DUNpujbmjay6e4Zvsik5yS7KhPgx9DZCyA5ZErKClG0I
         EbtRZwEcmk2XnCEkoo/j2HvEa3b9Kk6Xd9vtbb6wLOzD9H1g/CGqmWr/dwTt2gxTgh8O
         T6LKbA87nLsvKwk85o8mVxMhwYiC+RdHz0rQa1ef371s2REYeK37nYaBwGGeOoB+jrg1
         BdwVGolsli8Yiz0kZEbcDVH8G4kc+sa4sZWugDl7Vy7LRV8eIEGj0/UqjcTpTAwTrTvQ
         wlHQ==
X-Gm-Message-State: AOJu0Yza1G0ggcP4d82j5Lq7A+NoavqCelzK0hMFUQhiQ2O5ncPOd9ve
	wvE7rmL0oOlDCMI9VYqq8eQKsoT9+RfNt3tx3PJAWE3NnR1oIGbufCc=
X-Gm-Gg: Acq92OHUTbdENdU7J00itZGv4ikDnSuyMydfkBO+pJ060pSL+J5CP97al/2GCtGL9KY
	mDxvcTzQKMQOj2JX73DUT8smpVc4TdxNBz9ip0eIAkrIXbPye9/JKUl1eun9JpWiqRPn9b0pBwY
	glCECatpZmkq455rvqPBCkSvRZpAXdpUNHZiVG48mMlvGfGog2HWWjuiE5IZprQK8+dnaptNqRs
	iQLZlBm9ya4O4yo+Yf039/cXnu4lwDGmG03gDoYoybkA/GDs4w1kVQWClh6WvtLXfoEttI1slwT
	YPBVKyrxx3mN8wMKr3oRCCHXYgyF60gZpJ+pumJQxAN3HPpA+1QZ9VvGPRjtIWzajKhCoNap2Dq
	NSOjnZjMXegE/QQYnbBzciHfmPk1kl8zyzcqY9BB7LnYAcoI5C5b8onAdB5gXHm/ofgbJ5HNj/y
	YXzSnrw6EVcLNOEfFDNC+dzL99PLGhYFdgI3XlCLnNoUAAdco=
X-Received: by 2002:a05:620a:44d0:b0:8ee:e011:a777 with SMTP id af79cd13be357-9153d938abemr1568608085a.7.1780304651826;
        Mon, 01 Jun 2026 02:04:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.95.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915325fbaf7sm989492685a.31.2026.06.01.02.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:04:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
References:
 <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/4=5D_Fixes_f?=
 =?UTF-8?Q?or_=22mptcp=3A_pm=3A_drop_TCP_TS_with_AD?=
 =?UTF-8?Q?D=5FADDRv6_+_port=22?=
Message-ID: <cf1d3f81-4124-c530-65c1-b655c35c73f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:04:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/26744856471

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/1e=
1fdfa4d98f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103837

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
