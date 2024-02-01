Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510D779EE
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803777; cv=none; b=VLLja8BUNIR2m3ShmgAnQBzmCPQe6ZldaaOLltcioICaTx93tHKWi8pXAdmKcowQgXYbsTCVONrvl3LWuWjJeXra6mMTs2zir0zWhLhB6HZ0vutKfGMQP20Ja3BEIDDNbX6v+DUb07WL/BOeeMcZC1r03qjtRZ7qd1eg3dlBv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803777; c=relaxed/simple;
	bh=InKcmwo8gnCz1hMtzluizHE5VdWkFwy45NlvOB0w9Ko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QcITtns0ORS3VXB13bQcGFoqBAOf/CzEQS4sPJhbKdCK/rqk3h4eUvZzW91jjkUnXIC1J6VkzS1QhSSFnbVYLo/vF/LTz9pj3L1Qe0Lo/kw848hJk1MGc2Z3wsMWsigeALUUP4fvxcieBwbdpB3K8O9AKkSi8LOCmwfzC+VZeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6hu8Hok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6hu8Hok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7FC433F1;
	Thu,  1 Feb 2024 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803776;
	bh=InKcmwo8gnCz1hMtzluizHE5VdWkFwy45NlvOB0w9Ko=;
	h=From:Subject:Date:To:Cc:From;
	b=u6hu8HokboEdSKDlDASoiF0L3HRmMyPr3FjWnMBc3MtSofmhQcNPEFdHoZwVNp7z9
	 YFcIK0jLZzVyTJuLzGy5/ksh4tsEftVvJZH6iNhx0Y/8wZXEuK8yz8peP0RxioDKQ9
	 1bUNrwLFpqQBsvgzSm+dqEZ8SSPsyHSFp/w8oR7GdnCHcXnEUNq/kosg8SD27nblRC
	 f4wd8IE8ChcO8VV4fOgVJ+0I20it9oF8ledQt+FUCu0GEVCZxDvwScY/uKEUIsimNC
	 AtqwXhANK72pWkb/0s0YzYBRhnhqv2JrQ4tjsrOu34wsZb3pa+R9G5GIzg3phhmLOm
	 dYy6dFHZBxR9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/3] mptcp: check the protocol with DEBUG_NET
Date: Thu, 01 Feb 2024 17:09:28 +0100
Message-Id: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjCu2UC/32NzQqDMBCEX0X23JRN/Cs99T2KhzSuGrRJ2ASxi
 O/eYO89DjPfNztEYksR7sUOTKuN1rsc1KUAM2k3krB9zqBQVShLKd4hmSDMRGYWgX3yxi+CSkV
 12WOl2xoyGpgGu53aJ/wIR1uCLneTjcnz53xc5bn4L1+lQKGxwaYd8NXj7TETO1qunkfojuP4A
 toLifrFAAAA
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=InKcmwo8gnCz1hMtzluizHE5VdWkFwy45NlvOB0w9Ko=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlu8I/kuWP9cFnRxuhWhwFZekmRYr9R2LjQuxb+
 VkS+L9W1IiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbvCPwAKCRD2t4JPQmmg
 c+rFD/4tX+tE3VxzpJGftpgEdN6BIfRsxVM5565PX9S/cF9q7muYRxiSEf8rz+xC49jnTCUIA1C
 CBQujPeWPYVuSrL1utCfWEXIStvGiF456mQ2R/2xt/GtcSFBrMxbnt5IBbFDk/YN7tc8oNH+/AG
 t5yAj/YLftpVWMnxjYZ0x6QXVtpk/X0sGftxCTprb477ZGw5GduMwocec4xoLcppcgVnPrAU5l3
 xhkqIN9M9srPQZmmTiRMh+VWxGKp7raBOXUQPzJ6XkcLiQGE32yska/bOM565T9/LDkhzdH0+2A
 Vu8TH4yXj8P/fiFeKttVlUOjVEIGaykA6X3InbFLfeHk0t0JU6O+3P8q8AY2KWpAfb0+F8FP7NV
 DVjnVBjLusCMd8+BX1yrwtDftAvmWdeAj9cD7GReWSCVIUQ0Qhp7xWQBXEiMJ6s3ssI13Wp+WO9
 9WvL6xRc0Z/eXIWm3yR0mjxF041CJkktbrAx/hrZIt7i4wfPVMsRW6EyaXvF1hLYH1Z54V95r55
 suWGSZJRb70mvHa6vikcb601C8MOeMqUlGI/RffmbgnGpMEoPkeP4c3T9LBBreTb1B2P6g7SOoH
 ldHXKipJy4I0f9hXJ+rVvZE/7vH0//KsBigENa4XsZGtuOCbmXI6I19C1mwxmb2Rp0ZRgKxR9G6
 w5gWVWx8w+6iT0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, Paolo fixed a bug where a TCP-specific helper was used with an
MPTCP socket [1]. The bug was not detected by fuzzer or static analysis.

Following this, it has been suggested to add a check, only in debug
mode. This is what this series is doing.

The series has been split to be upstreamed: a preparation patch for
MPTCP, the modification for TCP, then for MPTCP. It is not clear if it
would be OK to add that upstream. If not, we can squash these three
patches in "DO-NOT-MERGE: mptcp: improve code coverage for CI" commit we
have in our export tree.

Note that the MPTCP Token kUnit test needs to be adapted for this new
check. This is what is done in patch 1/3.

Link: https://lore.kernel.org/mptcp/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 2 and 3 have been modified, please the changelog on each patch
- Link to v1: https://lore.kernel.org/r/20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: token kunit: set protocol
      mptcp: check the protocol in tcp_sk() with DEBUG_NET
      mptcp: check the protocol in mptcp_sk() with DEBUG_NET

 net/mptcp/protocol.h   | 14 ++++++++++++++
 net/mptcp/token_test.c |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: 12837771007b672717901b90aa9eb97a0a8c31fa
change-id: 20240131-mptcp-check-protocol-e32e53d04a75

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

