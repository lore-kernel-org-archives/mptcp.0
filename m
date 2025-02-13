Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0F23F430;
	Thu, 13 Feb 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452479; cv=none; b=APZRRLpF25QxPhm5KdUnJtZZ45euM2LmSijhIjBFO9rcbzJG7hVB4s4WWHv/Cb/tybR5eqQYWDBjXYsDcy1jgL5CJ+zR6AkGoUnAW9msm0RWrw8+MnTAlEbiaRMZwc84SQEJSUa3Y3jPcL/EAJx7DzO6KAib5y2n972QCTOYDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452479; c=relaxed/simple;
	bh=AE+ZCTpICKLZIsAumuIF/MKz2AhaRrX2zgbqNr4JY3g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ftu8v9VNn1SzXqkWM1t3Q4Et6B0AFTG5GXHFvAbCLo9TBa/WlyKdfHGPQuyrQCeA04/DCSWOTs2p+2zbNyrTZMw0s+a1OnnHskE/2m1C7OrrKqP77PDZp6Il48OtF3S/k26KahimIpD9BC9qwwYntOSRe8HVebNx2Fe3o3YoA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VCJCOqDO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VCJCOqDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99FFC4CED1;
	Thu, 13 Feb 2025 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739452479;
	bh=AE+ZCTpICKLZIsAumuIF/MKz2AhaRrX2zgbqNr4JY3g=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=VCJCOqDO3j3M0iIOnyxslM1FsZ041f/PN9n4mTj8fZhZo6nO0y/ZnhHpljZJVDYzZ
	 jUsc3/MOcHWolEKNjCxJ210oLJSJ8fvShal9Pm32p42hui/qRm07TaF7CN6w2uG3Y/
	 TPSygirJRiKxynpjuDRomRSGPnh0kuik6rKqk+II=
Subject: Patch "selftests: mptcp: join: fix AF_INET6 variable" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Feb 2025 14:13:48 +0100
In-Reply-To: <20250209174153.3388802-8-matttbe@kernel.org>
Message-ID: <2025021348-grapple-junkyard-3bff@gregkh>
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

    selftests: mptcp: join: fix AF_INET6 variable

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-fix-af_inet6-variable.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-114457-greg=kroah.com@vger.kernel.org Sun Feb  9 18:42:17 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun,  9 Feb 2025 18:41:57 +0100
Subject: selftests: mptcp: join: fix AF_INET6 variable
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250209174153.3388802-8-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

The Fixes commit is a backport renaming a variable, from AF_INET6 to
MPTCP_LIB_AF_INET6.

The commit has been applied without conflicts, except that it missed one
extra variable that was in v6.6, but not in the version linked to the
Fixes commit.

This variable has then been renamed too to avoid these errors:

  LISTENER_CREATED 10.0.2.1:10100     ./mptcp_join.sh: line 2944: [: 2: unary operator expected
  LISTENER_CLOSED  10.0.2.1:10100     ./mptcp_join.sh: line 2944: [: 2: unary operator expected

Fixes: a17d1419126b ("selftests: mptcp: declare event macros in mptcp_lib")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2941,7 +2941,7 @@ verify_listener_events()
 	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
 	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
 	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $MPTCP_LIB_AF_INET6 ]; then
 		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
 	else
 		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mm-kmemleak-fix-upper-boundary-check-for-physical-address-objects.patch
queue-6.6/mptcp-prevent-excessive-coalescing-on-receive.patch
queue-6.6/selftests-mptcp-connect-f-no-reconnect.patch
queue-6.6/selftests-mptcp-join-fix-af_inet6-variable.patch
queue-6.6/mptcp-pm-only-set-fullmesh-for-subflow-endp.patch
