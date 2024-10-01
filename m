Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7A155738;
	Tue,  1 Oct 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770839; cv=none; b=WRtppBUQo1CNYlaX68Pc3IF3slCFl+HiMyGgvnuoZf8Wwfr/FvAdWQIhZ/UD7BR0B31VjyDsTY/IjMQAiO8ZrYS2bATD1S2/1uO24bpGtN6EO0owzHdXGTfAjN664+5dZi1NSj/ot95rhoggnPJzenibh4ksaTD2zA90bQegdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770839; c=relaxed/simple;
	bh=JqXxwqzTdHga2r7VvXVi0JZ8PUa7VDm3YAVV2+9Ak9g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=eEo0aMmzsKbINCoEVG950uuWCClCJOWLguxTrajbOakluNjG2d7rAyEk4ygVI40+9OPLyHt7MHJUb4o1elEIh9wGcfpDivDt/voLMTrUb9DJ8TLycI1nU2fPYc0Z+Uw8g6js4uYsuxdthRNuoJNTJZs7+p9noiUGJ2NMZCExXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zTuw1Pqv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zTuw1Pqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEABC4CEC6;
	Tue,  1 Oct 2024 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727770838;
	bh=JqXxwqzTdHga2r7VvXVi0JZ8PUa7VDm3YAVV2+9Ak9g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=zTuw1PqvPl20G7sVhbJk9y3YyxCVlMYpVYt0b1Boha7+1zjvKs/y+S1tt3uRCc3F6
	 RpHC93VT/EUB2Zb7ACwKHpuvRo5l+EnB4g6dyAOmb/myhQhPfv2m+JZcUomt4VpNzT
	 KCoqwlQcwq86SvxifWAuh44SxsKSqty2mRUQL9ZQ=
Subject: Patch "mptcp: fix sometimes-uninitialized warning" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,nathan@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 10:20:24 +0200
In-Reply-To: <20240930162345.3938790-2-matttbe@kernel.org>
Message-ID: <2024100124-overact-matchbox-6cda@gregkh>
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

    mptcp: fix sometimes-uninitialized warning

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-sometimes-uninitialized-warning.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org  Tue Oct  1 10:14:56 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Sep 2024 18:23:46 +0200
Subject: mptcp: fix sometimes-uninitialized warning
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Message-ID: <20240930162345.3938790-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Nathan reported this issue:

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 LLVM_IAS=1 mrproper allmodconfig net/mptcp/subflow.o
  net/mptcp/subflow.c:877:6: warning: variable 'incr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    877 |         if (WARN_ON_ONCE(offset > skb->len))
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/asm-generic/bug.h:101:33: note: expanded from macro 'WARN_ON_ONCE'
    101 | #define WARN_ON_ONCE(condition) ({                              \
        |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    102 |         int __ret_warn_on = !!(condition);                      \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    103 |         if (unlikely(__ret_warn_on))                            \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    104 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    105 |                              BUGFLAG_TAINT(TAINT_WARN));        \
        |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    106 |         unlikely(__ret_warn_on);                                \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    107 | })
        | ~~
  net/mptcp/subflow.c:893:6: note: uninitialized use occurs here
    893 |         if (incr)
        |             ^~~~
  net/mptcp/subflow.c:877:2: note: remove the 'if' if its condition is always false
    877 |         if (WARN_ON_ONCE(offset > skb->len))
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    878 |                 goto out;
        |                 ~~~~~~~~
  net/mptcp/subflow.c:874:18: note: initialize the variable 'incr' to silence this warning
    874 |         u32 offset, incr, avail_len;
        |                         ^
        |                          = 0
  1 warning generated.

As mentioned by Nathan, this issue is present because 5.10 does not
include commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling"),
which removed the use of 'incr' in the error path added by this change.
This other commit does not really look suitable for stable, hence this
dedicated patch for 5.10.

Fixes: e93fa44f0714 ("mptcp: fix duplicate data handling")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/20240928175524.GA1713144@thelio-3990X
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -871,7 +871,7 @@ static void mptcp_subflow_discard_data(s
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 	struct tcp_sock *tp = tcp_sk(ssk);
-	u32 offset, incr, avail_len;
+	u32 offset, incr = 0, avail_len;
 
 	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
 	if (WARN_ON_ONCE(offset > skb->len))


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-export-lookup_anno_list_by_saddr.patch
queue-5.10/mptcp-validate-id-when-stopping-the-add_addr-retransmit-timer.patch
queue-5.10/mptcp-fix-sometimes-uninitialized-warning.patch
queue-5.10/mptcp-pm-fix-uaf-in-__timer_delete_sync.patch
