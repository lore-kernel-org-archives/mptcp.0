Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8F44E676
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434723; cv=none; b=V0Q+h/A+VhjmH03rHTTEWWG4kwe3a7wJ+xvxBTsy3e6xRNe8iI4vkkTrrFlPVkYpfov3i1Vw3rppXByISduYLc+1so1bFVHqyR0gK9ymShwzp9jX0vGEbYiVSV6x4KvHiU3GswWGR3kIZAxFkanqLbNFiSJK3XVSwNuR0zusOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434723; c=relaxed/simple;
	bh=dT1pRnqTHWNTL7NH/hwcHirg5z3cqtbAkThzAFqYkiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EqXAfO+4hCmvgODSYrM1GBXH2xuBdqXYAXA+9esuefhj4qMqn9sGppdnnw9X9HIc6tjc/Q3+96RHE+l93njMfXqeOi76tlbm3lRt5P9yY+y1Wdx28Xk8fE7/oCAUL4pcRgRgI1HpHz2eoVJs2YzfD3sE1eUeadE5d8PSXShwWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx9gVAfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx9gVAfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB761F000E9;
	Thu,  3 Sep 2026 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788434713;
	bh=P02lu3DNwGl/dtYai/h5g+rlMpOPz/pGqsvXOHNWHek=;
	h=From:Subject:Date:To:Cc;
	b=Hx9gVAfSuDyqIu7kuUvOXUoVbz2PmcZBTtBpxNStyi8IWVD5q7wh9+/G2/xPli4c6
	 1oN2YzjJXpzK2dtRnOl9LQaELRKcW5ohdRhCGit8n0DsHgyIKObR548HtR2VCXrIGD
	 V74t1moRojZ+mkHbrBJy+zWdhL/Q1J9TA2ruJHeYsyujrvObmW/oDJqPEaxh3cSOXu
	 Ds1HECOtAKM21xiybKigMtxghtg0kza7boCGo7XBSvZpA30FQwmpf/e2xfnMEDpF5k
	 A2XmeuXtZVbBrtctZbUL00cjzQ9SqBBADCC4C29Nk0RdFomdwc0BP7rL/a7l2QUv4M
	 kzceEDSt6KeBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] mptcp: options: MIB for invalid & drop
 suboptions
Date: Thu, 03 Sep 2026 13:24:53 +0200
Message-Id: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swubgC36K+IhTVddsWlIYimU/
 nujPQ7DzIosSSXj2qxIMmvWKVQwpwb+5cJTSIfKsGxb7uyFxlh8pFF70jC7D02xkPOm5TNbNh2
 jljHJQ5f/9YYjCLIU3A+Xv/1bfPltsW07qgx7zYMAAAA=
X-Change-ID: 20260729-mptcp-mib-inval-opt-ac1605020170
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dT1pRnqTHWNTL7NH/hwcHirg5z3cqtbAkThzAFqYkiE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmRorar5qkkWIyx29i/soPZS/4HCrqnV9HLCl5d6M8z
 9LBPYy/o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJLCxn+V55MiRJdp3BJKEBe
 IIpPR99xt8eJ3Um1c8+FmZQ2b/QsYPhnznLlyyzNnIX/3ps8qjT6avB3Eb/qjofRKUmpfiX7Zhg
 wAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few improvements linked to the parsing of the MPTCP options:

- Patch 1: Move the only non-suboptions from the 'suboptions' field.

- Patch 2: Track invalid suboptions: unexpected suboptions combinations
  or invalid sizes.

- Patch 3: drop any previously parsed suboptions in case of invalidity.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: options: use a dedicated bit for csum reqd
      mptcp: options: track invalid suboptions
      mptcp: options: reset parsing in case of invalidity

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/options.c  | 92 ++++++++++++++++++++++++++++------------------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  8 ++---
 net/mptcp/subflow.c  | 12 +++----
 6 files changed, 61 insertions(+), 55 deletions(-)
---
base-commit: ead8d38ce308bbb7375717d5b791b403ee0c67d5
change-id: 20260729-mptcp-mib-inval-opt-ac1605020170

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

