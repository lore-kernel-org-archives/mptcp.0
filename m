Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8C2101A1
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150534; cv=none; b=VZrT0ev7YayxIfZi69SZAJlFKd1zFeqN2zA3nz/8Ke6grrK2eyF/cv6aPG4q/W5U/0uemuQcdC0MdbGfOjwWntzhh0HA6mkDxO414hUiSWGnNejEOaWlE4x5UGaK6tt8zDCUtY1bLPNnROFu2HwJtE/bYjoYFNHc5fpuzseDf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150534; c=relaxed/simple;
	bh=DUpwVTmIJo7D48BhaKYDE9PkLU+RXx8vUUBOVFyYiPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pwp6K/025OTZx0dENGYuzATVROH3iY3mkNR4xAHnfMGyePJiIVbcyjL2qStGedG7BLxsf0LnRzTZEiVteM5Pg5+Lg3bYHAJk4IQguHrYsOrsSdDcigrlxBNI3RliJLnyURePGyXXoY5HaoG9yjoE6KUMxmNkWISLpHAQeb9gE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVdaqnZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVdaqnZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252C3C4CED6;
	Fri, 21 Feb 2025 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740150532;
	bh=DUpwVTmIJo7D48BhaKYDE9PkLU+RXx8vUUBOVFyYiPM=;
	h=From:Subject:Date:To:Cc:From;
	b=jVdaqnZSa2m2k5gYxnEUcFehUmjIz5yazNPKbkQK6+gFzPjRzNUPIia6qr4kB4B37
	 +g3Etqpfs7zUIldTexzG08W0sCMAHy9XqZVXxgZBvpp1VqYJcadkTWkG6at9V02yA3
	 BqyOdqOQ7li6LRT5dU1Cp7YrAml0nKqqimbbLwasY7qLZSnU+rJ4pOGo6fIiHXOsik
	 5dgomgcZMoLUJiI6uLpfvXdl+gBHZGd1+UacO0oolLGUXPiEqKcvMYV4Q1AmsAR/++
	 YCHCFvzSXiEVQd5SITcwRjUGALM2Y33v/A/15BLzEmRyBKTlSz3qTbUyblsO1HQIpn
	 CJulJeCQd43Qg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] mptcp: sched: reduce size for unused data
Date: Fri, 21 Feb 2025 16:08:43 +0100
Message-Id: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPuWuGcC/yXMSwqDMBRG4a3IHfdCDBWLWykd5PFH76AxJKEEx
 L0b6vAMvnNQQRYUWoaDMn5SZI89xsdAbjNxBYvvTVrpSWk98jdVl7i4DZ69qYZTzfyanyrAeWs
 NqNOUEaT9t2+6RUSr9DnPC7MFmM5yAAAA
X-Change-ID: 20250221-mptcp-sched-data-ptr-8740fecdbbae
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DUpwVTmIJo7D48BhaKYDE9PkLU+RXx8vUUBOVFyYiPM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJcDXRrCGyKLqimZPZkhGtySafIGONU7xlG2d
 JHXYUaiQUKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7iXAwAKCRD2t4JPQmmg
 czqlEADJ2ad6ah+8Ne420T1ciHJlRWTPpWk8LKmVX3zyhYl+FifP/R2cC2DMLNhk966uqSFBNvi
 V3oLof7vA8oYTGjEXFuqHTENDcoCHkXwDs5ApAUiX7x91LNVOr272ZMVrAVLr8Sc4vQchm6ToT9
 k7zR5fLnSNktIfJld9pTnEByyvK020vmrZJt2Bymatuuo60DbfPyyT5uoMXFNpDRdhtFvRdCpoT
 ekOzXajXm93gPQY2/QvunD9hbhD4e3ae8jvQ//wP3PBkajQGwGkRrqiSrNuX8knZfbzlsOWN8vY
 bGR1qFfYCgalo8anopRsR/XUuRcm4CoDjtc9Xl8DkHJKOxSyXTqEY1l1/1T4HATB/UZhS2Rg0HJ
 /122vBKSlwUDCg6CgPgXRvvtJrSh1dM+RgN6+ww/4nnl/2UzgPrW6eS/9pGtmDjpMx3cxvHyWT9
 ForItLVFXekyB+7Fat3OEtVYOmLpIdphEmsbz+6gdHPOrkc8qAbZa2dcH48oSJ8jQl1OLLDKg85
 hwVO3revUCu5BjnyxtZqVvFELf5hi9Q81/mzRZ7QLSrWBI9HRv3YQqXzS5oS+vP/NijFHqcHs+m
 zoUehHddYh2iaMujZ9+JLOVlHfvxl/LzAAjnQKDOB9kSUbUlfPodgw0hvhj9GYK9k+tpsuQ6ZHq
 SQOuBrl9IxZx8vQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

I was going to send "mptcp: sched: split get_subflow interface into two"
commit, when I saw again that the "data" structure was no longer used.

Because it will be removed later, when "use bpf_iter in bpf schedulers"
series will be applied, a first step is to save 64B from the stack for
each scheduling operation.

The first patch can be placed after "mptcp: sched: split get_subflow
interface into two", and the second one before or squashed into "mptcp:
add sched_data helpers": this commit can be dropped when "use bpf_iter
in bpf schedulers" series will be applied, no need to keep it for future
use. Same for the struct mptcp_sched_data.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: sched: reduce size for unused data
      Squash to "mptcp: add sched_data helpers"


---
base-commit: 98f1e7131283309b4684ce977f28c9703d16b516
change-id: 20250221-mptcp-sched-data-ptr-8740fecdbbae

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

