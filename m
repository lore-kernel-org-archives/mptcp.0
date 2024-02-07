Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27ED2FE
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270986; cv=none; b=HgpRcJVqvzLMYTrLg59Mq+RN5+MWpSIJ2GV8rs+AynSv2O6z15jfR2Y2CiOXb/FJR927n0P9O3ZIjxfxGMLt0wJX/F8ixUQgsxtRjcZiTJ8jMjvS8QG+A2ZmfpJ5ygJH1+vYGLaNKxUcSE68+7vwxtpuoIYLMJ26gQQmK/xSJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270986; c=relaxed/simple;
	bh=UQ61cEo/m9FDZSnTlOJVbNFEgJ3NI5x2JS4GxhnPbj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ivugXh1Hi9pJH74EuSPdBAqFcZAx1pJPh8jAGHrSE4m4XS+7WdvkfwY0+WWfgmqO/yFNP7CWQqU85X2kXATn8jhyKcmpbk9N7JddGhsIK86fudUVwzrGLt5wskzpRVWMStdAl4qDGRVDfx13pqshOtpuDdn2Jm5mp03YK/vnOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5VeGFv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5VeGFv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E8CC433C7;
	Wed,  7 Feb 2024 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707270986;
	bh=UQ61cEo/m9FDZSnTlOJVbNFEgJ3NI5x2JS4GxhnPbj0=;
	h=From:To:Cc:Subject:Date:From;
	b=O5VeGFv5LnSHZ6A92PDrMI25FbyseROjFbShlkSPdxmKKbdaRephREwHm6cHNXv/o
	 Mrf8Hamtq0nMy84vstpF9JVBqXYYECWmgsKREmWbi2bMH+urnLLwZIZM4p8mCqxNkT
	 uNzAM/Iv34nkQ2pglw7Xfg6G6KE0u89fY9OieNFLvPHHXmt+GyV5+oYPBTeyRGMmea
	 Ty5+crqNJx8zn7+Aqq8apTmaqrz9XzhmPp7Wnw1C4kLCHG3YFihqFDgKWI7SmZwt0v
	 wNCbZI/ymYMZ4baJHO43IBnoLfmCxR6xtKbgqEgoHhsFWbuT4pFMNBSohnnXyJq2PN
	 khUCSCa/ny3+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] fixes for "map v4 address to v6"
Date: Wed,  7 Feb 2024 09:55:12 +0800
Message-Id: <cover.1707270765.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - add a new argument addr for mptcp_lib_evts_get_info, instead of
   a new helper mptcp_lib_evts_get_info_with_addr

v2:
 - update selftests as Mat suggested.

Geliang Tang (2):
  mptcp: map v4 address to v6 when destroying subflow
  selftests: mptcp: rm subflow with v4/v4mapped addr

 net/mptcp/pm_userspace.c                      | 10 +++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  7 +++--
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.40.1

