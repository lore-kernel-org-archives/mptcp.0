Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307946;
	b=4xXRp5hdu3WQ18JproEnDBHSmxvgf4I33VCIkellBcWxGUmgGIK8+K7CmmuP29wYxlA6
	 CpHKPUqKIkn54wNB9+1rb5mtVTxw9psh4887/ELBR32NrYuNgEsELK8qHjveQPYer3Qk4
	 hzTtPiu9/eWa+G80yDvGnzwIkNILLxctiaMMJH2gwNfjhChDRCjsM6QFGtOP1apblXL+e
	 T0pIJHR2WuiBAFChlwtzmrsEnmeHo+7+hT0+iJqTW8EqINyy+TqIuJCFWfpZFFw6H3Mxl
	 XbYIJND01kNdqfkIqftylvvU3+Nnbj0Vz7+yBw7oRNQAgjxMPJYD16Bvk8g/cMRdgUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307946;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9+6kSI7tVHQ1/TNx4JHcFKOhj4cHwuHeXXKPBh/z1mU=;
	b=yGx31iPwq7tjwn9jutsaqkFKXHtzUZA6YqQmhnWg07ikkAZKuaAqT3sjYhCQ6JN0vw2z
	 vCyD8kJH1FXiR/6oKBOU4D39x5ygqSMU26VdN3WSQxuJgnTtZ8EkyvytA+8vnrJchvpbD
	 Y3Jde9mixM6ePL3sHKi+Vk+/QdTAbsL1lKok4nDk+WfuaSGT7jWPjEKG1z3vW8YiCA/YQ
	 0FB7R8Lbpxulghs1KC1zYW/ZTCbhRUAmWrxKsK8iFegK/aMlb9w/3hR7oA8wAx8brltj+
	 EFj0BJRSJXSz19mQTvLV1s7VV/4Q6waFq1Ukxq8Fl15CgiywfiUwc4wzL4v1Sdwa94A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxh4F+dz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BC606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxh4F+dz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B571F01816;
	Thu, 29 Oct 2026 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307945;
	bh=9+6kSI7tVHQ1/TNx4JHcFKOhj4cHwuHeXXKPBh/z1mU=;
	h=From:Subject:Date:To:Cc;
	b=gxh4F+dzwHtY9BinsEMlSKZq8hc+VU8XtguGwoN8pVGmaTZeT2/T4+PPoH1dtmsPM
	 IEdV7IL2SCaqujAh3jwawOO+YHQNSfxNdL+0naJdWcF6gfBOuzqrysrJ/N0w3pqG+R
	 nk0a0zUv746BMTe6018Awz26COVdWkntpy/LBmTSXN/+twBC7TzQc3nmu5zUiemH5y
	 LzpthPLgA0WsaDIIT97SLU9b7pI1UvG5FdKl29W/eWpF3UCDr1xMFYwjUSbC/Bl0xa
	 bBfv47wuyC4objkVOa36qJr5ph6NKBe6LgR2SwNe9w++yZtLdndUtiRNIOwfRWHQxA
	 KFnekY01n8Hgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 0/3] mptcp: options: MIB for invalid & drop
 suboptions
Date: Thu, 29 Oct 2026 22:05:30 +0100
Message-Id: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr2K6tmYYKIgr72FclDpiVQppa4Mh3
 N1aNpqw/Pnz3p+JObKaHDtsJmYpaKd7E0O+3TB1k6Ylri8xMwQsocKad4NXA+90w7UJ8sn7wXO
 pshIEIGQVsEgOlq56TNYTWwBDo2fnpXOv5k7Kf7Xf65t2vrfv9ELIEpPWashX10LGge8LKUSuh
 MCmPD7IGnruetumiYC/kmJdglEiKwTIL6ooUPxJ5nn+ADXOQsgaAQAA
X-Change-ID: 20260729-mptcp-mib-inval-opt-ac1605020170
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NV1SP6hEyyi2irxmLXLXzun9eEBkTobiFKR1NsqsCQM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeb1Vds03ytLWJ8+JzwR+UlXbLih7lTPmufNvik3vdf
 sUK/afrO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbi08rIcNq25dWaj0rG+y5d
 MTO95++Re8VEM0Xk60c3T9uA7uV1GxkZVgU9m8Kjf0fvg/HmjL4cz6z3fHfrpN3bv2XFfko273j
 BDAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few improvements linked to the parsing of the MPTCP options:

- Patch 1: Move the only non-suboptions from the 'suboptions' field.

- Patch 2: Track invalid suboptions: unexpected suboptions combinations
  or invalid sizes.

- Patch 3: drop any previously parsed suboptions in case of invalidity.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- No changes, just a rebase with a simple conflict resolution.
- Link to v2: https://patch.msgid.link/20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org

Changes in v2:
- Patch 3: break the while-loop, not the switch-case.
- Link to v1: https://patch.msgid.link/20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: options: use a dedicated bit for csum reqd
      mptcp: options: track invalid suboptions
      mptcp: options: reset parsing in case of invalidity

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/options.c  | 94 ++++++++++++++++++++++++++++------------------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  8 ++---
 net/mptcp/subflow.c  | 12 +++----
 6 files changed, 62 insertions(+), 56 deletions(-)
---
base-commit: bcc5638fabf418e763621a432840cf55287e604d
change-id: 20260729-mptcp-mib-inval-opt-ac1605020170

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

