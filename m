Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BE42901E
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505012; cv=none; b=TvZR2ka3SybrezKFr0ZhCn6uSvnubWziUYfm93DhKB7Id1QZn0p5gtM1xEmHqcvqT6IwG3NE/Kb9eQD3TbAH7zEYCJvDErqFvZ/ODIfVog4Fs3vDoAOHEtC+dl5ROzUdQGLCt7//A8M/VBetSHxjJCb7F/Qj+Y1SB3VPYKdUvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505012; c=relaxed/simple;
	bh=sK20vkdKaPLUaQSDMvUa/GLuSy+j6Ri3X2chqtYdoso=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gGSY1PeLecGc/CS3ryNk7LLx8KrUFhcRI/iX9lMQgtEi8u5z36vGVhxzeHrcIh+IWj4Xim5rUOUOnPPyLcjDUGM9l98ABBLckue1W6do37qonPZwSCkirh3COYWAor1ONb489Lhfe5sw55jraC5GjCONzuZVOS7KzjCqCgy+2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+kSIxG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+kSIxG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E35E1F000E9;
	Fri, 31 Jul 2026 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505008;
	bh=ttI2BvUvZfiMWuvPLT1/JM+NjH7t8MimDwDBThkrs28=;
	h=From:Subject:Date:To:Cc;
	b=c+kSIxG6OCAQ9il79GI7Bi35Ah7DGO21uJGPxIY7ztwpglurP5MNgwm2rDibuoC+S
	 p5JUpYsaVbVtjwteNffOllSe4xz1p73gDsnMx6vSKh7+1cboUY9m7Q+Kycp0assIo8
	 0DaKgrhqQcTPEiHfDkCJGaCJvfokT6k/qkw1W15p10snSyqSVwJcOVD9eJCRTsDCCg
	 HfxnCtfWW6lSnE75JeRtXAF17QSlE8otHDNHPwFAlqdN1gXgZFte171EIdgCGuuz++
	 IchjPnTi2bWxUtx3cKFvbcsSQJ35vwcLA6sbAeqQ1t/VWntZJvTElNofdkCqB3j1kD
	 0ppz7iQIXqBfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/4] Squash to "mptcp: misc fixes for v7.2-rc6"
Date: Fri, 31 Jul 2026 15:35:34 +0200
Message-Id: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMAxFf0XyvIBWqOCvjD3UGGeEdV1TRRD/f
 dl8PJx77gHKWVihrw7IvInKOxo0twpoDvHJKKMxuNr5umsbfKVCCfWzBp1xkh07dJk88kh+CLb
 iicDqlNns//kOVxS5wONSug4LU/k9w3l+ARMWNdmGAAAA
X-Change-ID: 20260731-mptcp-squash-fix-7-2rc6-edc6ba026efc
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sK20vkdKaPLUaQSDMvUa/GLuSy+j6Ri3X2chqtYdoso=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJylrx20eiXSLkxPfCqRla6ietkL7nXOVZneyqlg+Ytk
 nvfnPKjo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJ6FowMlydatpnZTmVclM+T
 +oZPjeeGa6+JH+uzdeluUy68nxyWyPA/MpNRRLigZ3HjK+HT8uzn+q3tNy/4OTMyXqi0tjuRjZc
 BAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Addressing comments from Clashiko.

Note that patches 2 and 4/5 of this series will get a few more
precisions in the commit message to ignore more silly comments from
Clashiko.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d%40kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      Squash to "mptcp: avoid combining some incoming suboptions"
      Squash to "mptcp: reclaim forward-allocated memory on RX path errors"
      mptcp: options: reset DSS fields in case of unexpected size
      [mptcp-next] mptcp: remove MPC && MPJ check

 net/mptcp/options.c  | 16 ++++++++++++----
 net/mptcp/protocol.c |  3 +--
 net/mptcp/subflow.c  |  5 -----
 3 files changed, 13 insertions(+), 11 deletions(-)
---
base-commit: 23c7cb4262d954b810468b0e661d48af82b418d5
change-id: 20260731-mptcp-squash-fix-7-2rc6-edc6ba026efc

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

