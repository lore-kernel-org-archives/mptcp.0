Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797813A3F7
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874242; cv=none; b=jLzb8kPNfc/3JIvBmQl8fGm37Eyq17BJBeJ1jYMC2H9GkU1iG2CE4wBOn3cdLjRuZlOlDd84KyYxLx/dRiakQ9NiOJ6Gp8wl9Kjg0s12+8F5f4tB6NCblDLzODtVeeOB5QRU1hIMaNVL9jGdjiN5Ha3UmRuuKs8R37lpbOp6O38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874242; c=relaxed/simple;
	bh=mAMpc62q6w+n0LcrfNjaPsa46lUuR44V39m0DdR3cCE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UUeZ0OAyPuDUw1eDMuGu0HiZcCZpJi205ABqy/BihAzgGt9oteETxa6IW0CvyiMlyI4dP0PtHLqufyHbnrIN8PtIA/Ks0VuD1U7QMak8H2fM5w1bNOavm5H9Z+zYDLCUqSvcOLEinXbVggUhz0jHyUEQs0Omy8nnEVZbP+K5BZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPf1MGqo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPf1MGqo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c703c471dso31578515ad.0
        for <mptcp@lists.linux.dev>; Mon, 07 Jul 2025 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751874240; x=1752479040; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv5h+20mU6y+idtrqYBbZt8HLTTY6c+uaoj8jn500mo=;
        b=OPf1MGqoqszOtzSTfwwNkwSrAv1d/svWGbDVAGByUYx2Z20dd+XHY5Mawlnap/MLVZ
         DRTs+va6BwIY5lNJP8P1tY0YNHO6HIfBwjZo8NsXcn9Wdt+13SURY8zKnfsiJquv17oV
         cgwRJrz/PetbwCRKLk7UPBFqeTfpPof1Hi1B8ZebemIFG3GNsAdEenQinOWyjrYzL4NI
         HgrE9TslBtU1uA5t2axmRV0aU+b4QsI8ARpwIwrxWnJ+ZiwPnvKoI/7BD0AyWSV/9KqE
         QAZSp4tdV2TJj7Au+kKyBi+Q0dep965Z0uMaKkpb/L1+Cdfz9rp2lbQA2+ElZSWO8KRN
         jz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874240; x=1752479040;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv5h+20mU6y+idtrqYBbZt8HLTTY6c+uaoj8jn500mo=;
        b=Jo96pcaXJsBJm4K45Rl2AdWqTxFo0mcisj2Hf5TTDmDF75wftOdwS6L8p14Jf0QDAf
         rDMG12YIDvgda0RmmJOM7ZR5mh+vI4IKEYSxdyThuGp2lGkMpsT8X+NUrxRbqFaF/9aj
         shU2Uj13kJUd+pLL+TqP4NLmJvEoxa40TUuVQ6/9q54I99vAvhSYRPmRcsYvID66GyfL
         nl4ax4Q3W0hq2AyqUmxoLeGm/phU5c08vyYDCuw8K3EQovg+a4gJfa6u1RoN3Hg6XT2D
         raxhT1rGVOXGr7WhacWMDaBpOMm9LeL8fn6s+6W3kmmEIVyTcQ/zBgPg8zTqnIjXvvX4
         ZXgA==
X-Gm-Message-State: AOJu0Yy7Iy1SqwSu98jpFavfCDyeNkUvnzwWhcAeOzZdBTdQEOd5jzlV
	484L66fIlKNqKBHRHGwkdjFzVUyyPvWJG2QwUBBox8R7TeVtEX0JJso=
X-Gm-Gg: ASbGncsjvitXyCPpt241MzhcoIzUuThcdhULGASGn+vtN0rpqIRQkR6NKQm56wpg2EQ
	iCrVcNEfee9ZIBfxe1L84V/o1onjpAalVnpx3mE+/Z3xgXA7fCNdHcF7153W3+AbPhIN970nl2q
	L1RJVZfA6XwEShhb6yNRSJkTzK319c809MM4Xm5CwHO1orwE6DrnaV4ucMOMDJVOc4GCWNSylz5
	a8DB8+kZE7ieEVLDEd7PuOAPCdGia1AO0LjMidSC6YeDlCBic9Fm/6T5Ythhq+hA8sNuH0Z+PpM
	eVtThd/6AIBGvvsO+0MSzJCgmzXfKuJ/LCCPy0DlYnPOh8IpWBw2YxNEfH/RegaMYiHDc/1nNQ=
	=
X-Google-Smtp-Source: AGHT+IGSvUd8nIDdCgk0KVyke6GzeWCUFe9stXbDdE2s/1ABmUBnKeW6iCvd1N88VP5+lfwTMda8FA==
X-Received: by 2002:a17:903:2a85:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-23c85886944mr194078945ad.1.1751874240228;
        Mon, 07 Jul 2025 00:44:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.70.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ed76sm83215835ad.13.2025.07.07.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:43:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1751699999.git.pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/5] mptcp: fix fallback-related races
Message-ID: <3df6322f-7397-5b0b-8812-8b0b90f840d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jul 2025 07:43:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/16110745400

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/54ab1b69acaf
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D979295

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
