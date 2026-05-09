Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61542050;
	Sat,  9 May 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330858; cv=none; b=Av7eEq6sdpF4QCN9MsQLu2zlweokA7BqCQbqsoxV1c1nTJPGPmt9Elg8XkYx+3QGsIyS2CTfK36KXzhbAApVNnixWCS6fHN/AXDVoJ1Irb2j6sOhBsr4d3se7pe3AjZ12YuoRnpT4ziu5jFelyfg+sOC4c/aHucpF+fHhiBPPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330858; c=relaxed/simple;
	bh=z3+Q7JXISeJY4rYs7nCpcWc2Jwtfqe96g1RzkxcR49o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLyOyykuL4nwThGcuEZPI1ovMoX3zNfii+nSirey+mWHuCNngAGfZ/zg7vtBlDZ9c3UPQXJ3nfTtxeMioMfxdVbgBBkRvIdl1X4hnBPOoi92tRhUjQVZIxj2+iPnRUyFHmMgq3w6Ynl+g0Qn3OdDGfWg8oZG55K8MNJTlQlqRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aONztXs7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aONztXs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23899C2BCF4;
	Sat,  9 May 2026 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330856;
	bh=z3+Q7JXISeJY4rYs7nCpcWc2Jwtfqe96g1RzkxcR49o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aONztXs7xmBaA9IQWZhnISkHmjGyD5keK/l+4m94XqoN7ZoDugVhZhxTNqepAvzaI
	 iJAl3PcryOtqp4rx0uHguy+2yp7HizqzubsNr36AsvlFdBz82iCrQjSm9e+VQrU8Yl
	 TQYYde9Qt2vzevKELYJBj+i8yEBpZzqqUfzl9180p6mzuT7r2d/4mkTgbnlq5ryCRY
	 Hh2cTqqrSo55tQ8mwa5bNXldYfyJRdhFPLyQRuB7puVMvV4kYYJjfReIFmGLnxiHrQ
	 NUZsRl2xNfqn4Jl9V2j4GhPKEoIuusqjltLGTISSftdVStJbVk8V062Nx1cg+atYw5
	 WyC8CDoOkWR8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH 6.18.y] mptcp: sync the msk->sndbuf at accept time
Date: Sat,  9 May 2026 08:46:59 -0400
Message-ID: <20260509122858.5394f7549c56.re-mptcp-sync-sndbuf-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506112040.3503275-2-matttbe@kernel.org>
References: <20260506112040.3503275-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] mptcp: sync the msk->sndbuf at accept time

Queued for 6.18.y, thanks.

--
Sasha
