Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EA2192F4
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611687; cv=none; b=HDe34AAipfRMPQqYbEU6jUocTUPLhlzPKhKTdQbD4Mvv3lVMI79phwIOGEcX2N+GgUcS2IKhM0RvCjW4+jHJUNUBZirZYyhHgURDeKJgTgd+ZKyHsGhpgPEVqLaER4m3NXzbLzZjLwzFHKuzxVOc3TXN+Y5avlsCgr27OVxijow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611687; c=relaxed/simple;
	bh=hWuemv1OMbw466kbDf3denmZ2uH7i8HW1J0NRXIiok8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y4Uan4a+eOcubaQ6kydArJLrFpa8KWPe06qY+/3U+kr3wfCPgd0VeCowAaEaJ58b1Rz3cXB+CBmnKop3Mdqhk6ZIKxM6KrJYEZwBGrah4i0r4TCB+cCi2O+xgnUbqUpYKD76U7FFAgdI0f4X7L5pqcETDQi+FCLJvLtzAvkQwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtKW8eLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtKW8eLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E602C4CEFB;
	Sat,  8 Nov 2025 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762611686;
	bh=hWuemv1OMbw466kbDf3denmZ2uH7i8HW1J0NRXIiok8=;
	h=From:Subject:Date:To:Cc:From;
	b=OtKW8eLWrZrJPdeUZTjfW+pL0iqAVlHaPj6NEDIQeTme871TjQoayXgCkYjGuqyPs
	 T6o+IcDfBNaCKHbFW+ZQokDeaRXQVBnrPQ6HSoF6HDCywqz1/kGsdwHM8Lf6eirgEn
	 bc1w5ePblH18Jr1KBRIO+SXlrIJhfTesax6eCJ/aXEfrSLHOO7vimauLU0MJh8Q4JI
	 Jsl8vOhdPyYSHnJiPLO84o0vHp31B6uzrJlA7q3m8XcsiJGrvRZX+jaBI2Z16xS9oh
	 bjNpDyo0VdnvSEsVuJlf1oSypCgDt0Aq/oKeS3eje99UoeY9eejCKBsd5AVISLC3tV
	 ymNk2GZv+OOMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/4] selftests: mptcp: get stats just before
 timing out
Date: Sat, 08 Nov 2025 15:20:26 +0100
Message-Id: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpRD2kC/x3MQQqDMBBG4avIrDuQCFXwKtKFTf60AxpDZloE8
 e4NXX6L905SVIHS1J1U8RWVPTf4W0fhveQXWGIz9a6/e+8G1jUZm2zYP8ZqiylHN/iIMQU8QS0
 sFUmO/3SmrVgonHEYPa7rB4ZjVQ9wAAAA
X-Change-ID: 20251106-slft-timeout-stats-d061de7fcebe
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hWuemv1OMbw466kbDf3denmZ2uH7i8HW1J0NRXIiok8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL5Ax9Mjkva4Lj7Zenx0g1a38Jyza/012kEtv6O38vyT
 CCm+EF2RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETsXBkZjk+r3cR80nm1v5PW
 sROz382e+KZzgeylO5wX94mGl0oKczEybG8t+fD7cpO8ZCavQUdZh1nD/hRG3s8Wln/YNINN1de
 zAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few patches to improve the selftests in case of issues:

- Patch 1: a fix to properly kill background tasks.

- Patch 2: avoid taking the same packet trace twice.

- Patch 3: wait for an event instead of a fix time.

- Patch 4: instead of using 'timeout' and print the stats after, another
  internal timeout is used: if it fires, it will print stats, then stop
  everything. This avoids confusions around stats in case of timeout.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      selftests: mptcp: join: properly kill background tasks
      selftests: mptcp: connect: avoid double packet traces
      selftests: mptcp: wait for port instead of sleep
      selftests: mptcp: get stats just before timing out

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 31 ++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 47 +++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 34 ++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 23 ++++++-----
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 24 ++++++-----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  3 +-
 6 files changed, 106 insertions(+), 56 deletions(-)
---
base-commit: e3f3a4ba83a02423a3cb045f7485340b713fb549
change-id: 20251106-slft-timeout-stats-d061de7fcebe

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

