Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA483F54BD
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373275; cv=none; b=rOFLuvcU0FJq87lNHH3W/dPbFzWUAbu18KQxTzQyy4LVMfIE2oPUkgQ8gafNH3i/1UfBY2Gb5plxCV5C6QOvMaenN/L8XW4pFJ3K2yvorsI5KccXoH8M4Ttlele8CyKjPxeZwn886tla6wm06guMIauFZ9DN45l4yD3SqFKW3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373275; c=relaxed/simple;
	bh=y1EPCoAJICTj8QZoxQEkMi4nwQ21brzjmvuXNMLa0JA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=samwF1Xrtj7MmzIRKLrxHOMyNhWHxPofiNMQKZDyuc1PyJmkb/XG3/sd+02+022is5m+71SNjIrO6eeudGltLdx5YBkucaN55bOZYMIJrw8syPjR3G/QQ0Yy40OJ9bavsFFok/jqEDubo61mDrsuN+CnmmIujxIWgfrTLhXYyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdxCFLzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdxCFLzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F26BC2BCAF;
	Tue, 28 Apr 2026 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373275;
	bh=y1EPCoAJICTj8QZoxQEkMi4nwQ21brzjmvuXNMLa0JA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=JdxCFLzB0Se6kO6pwMO/CWyJCd2AyojIQNbmqdzdXiOqLYHSFMTLfdKPXFq2avCp7
	 uOUPXTsj53x44bB66B9dno4J00UNhSm0WJCtf0bmeaaiQC9J3DQhzi4pAIAvFt6L33
	 ze0uKzqM0aGaciRRXlGkCU5lymTgPbhS1as/6BKf0Alm6yAYSPQzdY41rz+L9LAfJM
	 ywbTb35oGZfrtNvotAGmZ0NlLJwEOdx8FWDM/GdQf37zPBfrzukJPn2YRhD4bL8SEf
	 shs4umDr+hpu0APJrSPt1+glyjBGmjBFqcq6uTK4MwgznUcouVWPyyW/uua4MGx6bC
	 QtzygPXxaXxHw==
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
Message-Id: <177737325925.3955012.7065583967711667306.b4-review@b4>
X-Mailer: b4 0.16-dev-c7348
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y1EPCoAJICTj8QZoxQEkMi4nwQ21brzjmvuXNMLa0JA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/TAj3Dn1Zck3aYW6kSO/PCdpntcsOKP69oXHjhfjO2
 c+6qjz4OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby8QLD/8Tfrc/CZ/O3JHGG
 yx442DN3O4PFYtmIeVff9+6b5bDesJvhf+jsp6XHJmbs/Ngm+G/l4pwjBhNbTZ+c+16/LfVTyEf
 9QD4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Tue, 28 Apr 2026 05:19:34 +0530, Shardul Bankar <shardul.b@mpiricsoftware.com> wrote:
> When HMAC validation fails on a received ACK + MP_JOIN in
> subflow_syn_recv_sock(), the subflow is reset with reason
> MPTCP_RST_EPROHIBIT ("Administratively prohibited"). This is
> incorrect: HMAC validation failure is an MPTCP protocol-level
> error, not an administrative policy denial.
> 
> The mirror site on the client, in subflow_finish_connect(), already
> uses MPTCP_RST_EMPTCP ("MPTCP-specific error") for the same kind of
> HMAC failure on the SYN/ACK + MP_JOIN. Use the same reason on the
> server side for symmetry and accuracy.
> 
> Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Fixes: 443041deb5ef ("mptcp: fix NULL pointer in can_accept_new_subflow")
> Cc: stable@vger.kernel.org

Small note: when you send patches only to the MPTCP ML, no need to Cc
the stable ML: this line will be added when patches will be sent to the
Netdev ML later.

The rest looks good to me, thank you for the patch!

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
