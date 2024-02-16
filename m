Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FD170
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041794; cv=none; b=Z6R3GTLXgIi3VM4a6XyCrqj11od1OwWpwprBiJRJLPLC2KhpeKy5FHJ8tYEyUQWiZgcJDY3RAGstxzDhiQEN7IrY6qZzXWiKZ5IpnIrZkTLKRG7c4M7/08qn7MPhUfHMcMIyt320v30ySRrR8rIvhtelDMnwQJObvhwgq+Qjv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041794; c=relaxed/simple;
	bh=kEHbP+IHd1qNsbFpFGRP/uUzBLhJ8/PxvKUtC7fVO0c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V9sQS50+VrOwNEDfCvUtg2oFhjf4niu6jdTIq+pQAlKzJqb6vJ6I76Zjhkl3m8dM1GVT/t24VNa31v1lJSBceaKJhMKsI/tDYTxPSs2nTCVd1pkdi3+aOH4a8c/kqBAGo6IiT5eQtO9qj5CJylfrQSiNDtGha+HPsDZQGNP1/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKFl/lO7; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKFl/lO7"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1415670276.1
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708041791; x=1708646591; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=638LltJqYsuM3GiK+4t2buaQr72RWBS/Uc0ZxBKKT80=;
        b=KKFl/lO70WPUxVZhs1MBIJTt1EtTFPOEIRA/JioKoTKOtWQIKpKd5msFycZAsABrY9
         v5g38zqlTT/XxjJzrs0odQ7DNHMe9Qm5JTa+g+EcixhqAxg5bcYKz+gq3Rm9hMBiQvkc
         jFLoAZTyZcPlgUDuuGdOFKN516lyBmPr12x/J2DUZa+sNnc/F5jAfUQ8bSzOUVOykPjJ
         WsYSTmimkvEKRzQ0yQYJSO/sdKTxsqJP2zYr5gqcnRam7+Xujo3DBhpc5NqGb3hBYOBe
         YuRfWKG2vGIb0FWvX4fW42D4Lb8wmRpPIslvjX02sl8GPNzE8UMZyzVyexgs6DVllu7b
         bSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041791; x=1708646591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=638LltJqYsuM3GiK+4t2buaQr72RWBS/Uc0ZxBKKT80=;
        b=SuVt99xfAObrkRw0LM9KTsw+e8Ovqumll8QNGEFcXtxZ+EcnQEVJXe4aXT1vO8Cb7x
         hpq6ejhF3Gf/FCjUQVPfnucagR3RysTtoyZCjimODvbUCzwCheqh1zp02oqXzX+DMrTl
         7mWU+Fn53syTEQ5PMePupqfPhYpZfzJQjbfFkjcc3ZroyI0hL4GnrMyJaR6YnKPVrvC2
         1zbdwjHsQdPTv+Bj2CYLaDBhpkkKtfqA4yfh1HUZYh3Nj1fd9LxrMhSogpDBQ5ZZoz5w
         udF+ccxOK6QbId/3XGpaJoj4CjN5PNr0H2fBqHN9nsqrv9a6Ggaixxwp+3n+G+REto1S
         XGlA==
X-Gm-Message-State: AOJu0YzwNrryxtW91LgY6XDbhF3Ttu21ccbqrfmg29y8rXqaiVGyQthz
	em9myMOtDBkG0AY/xP2vM/qRlGAlorSOZ3kynHIv3BRe0qviStVB/MUACzE=
X-Google-Smtp-Source: AGHT+IGaqnLGl6ZvfeNjGOOsVz03wBoehW2G0Lbxi5DQGu6/VzYxKtoSRG1yRVUqAiODmC0yFBgcZw==
X-Received: by 2002:a25:6b46:0:b0:dcc:f6e2:44d0 with SMTP id o6-20020a256b46000000b00dccf6e244d0mr3311319ybm.37.1708041791462;
        Thu, 15 Feb 2024 16:03:11 -0800 (PST)
Received: from [127.0.0.1] ([172.183.53.130])
        by smtp.gmail.com with ESMTPSA id ow3-20020a05620a820300b007872d50caf5sm1049575qkn.19.2024.02.15.16.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:03:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <275b21e5-b31d-fac0-ce08-c303aa99014b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 00:03:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7923641372

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e79de30e413b


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
