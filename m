Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384B1C84D7;
	Mon,  3 Nov 2025 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134244; cv=none; b=O9+TxxXv13BTTTG4KlHvV2nPTboU2RNjUpMGFTvOTPa5rT3unMwcTl6/VJ1YnRPI/hvj2q9XefkeUQDmJ6ZaDulfAzzkZoN0jyABhPAg/1opNFsZTAN/WquH5wbM3qNDLrOeTTR6/HUsTUz2FPCi2uBmFjZBS4exmzhXXg5pJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134244; c=relaxed/simple;
	bh=QZEleg33Kxk0d3xKDHFwmmvx4ccvsPekpNgrLIPQdbg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=sWonaRg8lRX3C1f7Oj+j0di8Z03Wh2ppwHJm9S3rdCgKTGUtI8mGRrqe4mG0qVkjkvmIat7WzbRCT6+U2fhkMIom5wlAnbg9E03IuMtSp/fjk8HqXCnbUnbipfdH7+srziiEtLw6OhpLgcA7IbYd85rfewEDaxHHRWDm51hpmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSTOxCL2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSTOxCL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F204BC4CEF7;
	Mon,  3 Nov 2025 01:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762134244;
	bh=QZEleg33Kxk0d3xKDHFwmmvx4ccvsPekpNgrLIPQdbg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=wSTOxCL2sDE2LAaOzbmHPwFexS3VYuyBpUvt/WZv6+DgwpGc6mGHC2Y6m8HKHIjAv
	 2uaLIGXLlARXGXK0cYAlF4G8NTDg3DFWeDNWDyQy8QtFxnSHkT3F9jyTCLHTI+sX8Z
	 Sy20uWXUSo6hOf1gyIQdsax+lrS4kf2UqE4+JWfg=
Subject: Patch "tracing: fix declaration-after-statement warning" has been added to the 5.10-stable tree
To: douglas.raillard@arm.com,gregkh@linuxfoundation.org,mathieu.desnoyers@efficios.com,matttbe@kernel.org,mhiramat@kernel.org,mptcp@lists.linux.dev,rostedt@goodmis.org,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 10:43:52 +0900
In-Reply-To: <20251017-v5-10-gcc-15-v1-3-cdbbfe1a2100@kernel.org>
Message-ID: <2025110351-tricycle-hesitant-f6ef@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    tracing: fix declaration-after-statement warning

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     tracing-fix-declaration-after-statement-warning.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Oct 18 01:53:59 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:53:27 +0200
Subject: tracing: fix declaration-after-statement warning
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,  Douglas Raillard <douglas.raillard@arm.com>,  "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,  "Steven Rostedt (Google)" <rostedt@goodmis.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <20251017-v5-10-gcc-15-v1-3-cdbbfe1a2100@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

When building this kernel version this warning is visible:

  kernel/trace/trace_events_synth.c: In function 'synth_event_reg':
  kernel/trace/trace_events_synth.c:847:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    847 |         int ret = trace_event_reg(call, type, data);
        |         ^~~

This can be easily fixed by declaring 'ret' earlier.

This issue is visible in < v5.18, because -std=gnu89 is used by default,
see commit e8c07082a810 ("Kbuild: move to -std=gnu11").

Please note that in v5.15.y, the 'Fixes' commit has been modified during
the backport, not to have this warning. See commit 72848b81b3dd
("tracing: Ensure module defining synth event cannot be unloaded while
tracing") from v5.15.y.

Fixes: 21581dd4e7ff ("tracing: Ensure module defining synth event cannot be unloaded while tracing")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_synth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -831,6 +831,7 @@ static int synth_event_reg(struct trace_
 		    enum trace_reg type, void *data)
 {
 	struct synth_event *event = container_of(call, struct synth_event, call);
+	int ret;
 
 	switch (type) {
 #ifdef CONFIG_PERF_EVENTS
@@ -844,7 +845,7 @@ static int synth_event_reg(struct trace_
 		break;
 	}
 
-	int ret = trace_event_reg(call, type, data);
+	ret = trace_event_reg(call, type, data);
 
 	switch (type) {
 #ifdef CONFIG_PERF_EVENTS


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/arch-back-to-std-gnu89-in-v5.18.patch
queue-5.10/x86-boot-compile-boot-code-with-std-gnu11-too.patch
queue-5.10/tracing-fix-declaration-after-statement-warning.patch
