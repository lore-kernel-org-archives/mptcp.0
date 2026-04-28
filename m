Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34293F54C8
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373274; cv=none; b=BwgOmYtQTG4TJIOXeqe0omLuAFg9kcY44RrWtwgdQXHgHgb+0kug8zF+Ruej3iHCwdnacWwhl5grqBB/35kmXc8Jj76WlxqVJ2XERgqS6gEv09KfO5nLq+Rx8i7ObX+/CNASFmvhgvYV46B+nm0O4x5ZLWlCtLsrISG9TkQRoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373274; c=relaxed/simple;
	bh=a6RuYdVtOFx0n09GScVZwpxe5+KGhJey+8p226kvluA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fCzzy2P3YlQ9T46j+Kan659os20vqjTEy3qEvAUw/Jn+aznWd1EG2RemmpLKbDhv+/KgVyRzXwv+1ozCTJFISeLgTKKfUyxtJysitIQ/tmNgOS0NSJESt8ohiqEkUhsWqlJtaR/ad5aplNUMc4wZE9rSZ0GIx3W/JmrzZcokfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYVwk2XG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYVwk2XG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5971CC2BCAF;
	Tue, 28 Apr 2026 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373273;
	bh=a6RuYdVtOFx0n09GScVZwpxe5+KGhJey+8p226kvluA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=NYVwk2XGKBGjtZPpk1i81NYQ+Ky18nCEexPOzEEkycqcKaCNIcBuaFAmFGck5+LiK
	 stXcZGdRsdO04vsXVGtY5FqM7U6p8ueUsvzWmTHvLkVrYCm36LKktiINFG9VEpP1cp
	 K8YCmHg3i01VizqfFdV2g1G4J0lWKaH04ePXBF3smThLTLaQJpjv2Mmg9wncYaqSK1
	 6DH3AMcMDE+R07HIBENEEHsiw/TCnXmF5RN1hVTmnidrRxKUu7S5yylndQUldHo9yA
	 f7l63a6SEQ+sJdUfkwSJpF7qe0n6LkAtXlP5swJ7LfroIIceUBXoLQujNfKr45iaQc
	 hp6GKew9D5Stg==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net] mptcp: use MPTCP_RST_EMPTCP for ACK HMAC
 validation failure
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
 pabeni@redhat.com, janak@mpiric.us, kalpan.jani@mpiricsoftware.com, 
 shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
In-Reply-To: <20260427234934.1611893-1-shardul.b@mpiricsoftware.com>
References: <20260427234934.1611893-1-shardul.b@mpiricsoftware.com>
Date: Tue, 28 Apr 2026 12:47:39 +0200
Message-Id: <177737325923.3955012.4365298395400560816.b4-review@b4>
X-Mailer: b4 0.16-dev-c7348
X-Developer-Signature: v=1; a=openpgp-sha256; l=265; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=a6RuYdVtOFx0n09GScVZwpxe5+KGhJey+8p226kvluA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/TAhTWd1+5FnlSvZvKlf4mLas23Lma5Re7Lxfz34VK
 O22mtbb1FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRSxMY/gf2CfvWbZGRYk/8
 eMY5fdH9yAWzliZkcQrECtt8nJyy24KR4RzzopONj7J5wh5f3rC8fvLPF/Om/D4mV53+0mS1zuQ
 XH3gB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Tue, 28 Apr 2026 05:19:34 +0530, Shardul Bankar <shardul.b@mpiricsoftware.com> wrote:
> mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
