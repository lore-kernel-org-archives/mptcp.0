Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A881AB525
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708940; cv=none; b=ZGCWQHZP03WhG5MXpnMzlqjk7k+CI6xJlJwEUqIHAL74Zb2pxceyYZ99wJXw4Dadrb9HjzSrwXEXImZuIFJuOo8DC9YraNmxbIIBoba4qrkwE+gJN+qUedvpsECiL0sF4eRXUYkjTIzNu45znXlEDOwTqNUhoZDd+oL9v0R71EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708940; c=relaxed/simple;
	bh=s0nDzPY427YRtAu2YzNiMOtyS7/wvq0T6Y+uOuCKjXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQ5KQc1omVYZP3yU5xz7w2fSppUbwT/WUqv3k0OyBwV4p8bKGNz+Iji6/wA26Q3eReGAoIKbyEsWtwm7qc78RHz723pBOWKTcB6DgR0XJEFn2Eo9etsc66L3+jsSOkBM2FZtaerGn2bYC9WyytpnoDAkQkJAdArZlhVoJ2aX/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyPIS5GH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyPIS5GH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D61CC4CECE;
	Mon,  4 Nov 2024 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730708939;
	bh=s0nDzPY427YRtAu2YzNiMOtyS7/wvq0T6Y+uOuCKjXU=;
	h=From:To:Cc:Subject:Date:From;
	b=qyPIS5GH1P26Il9YpHL6DjNjQ+htov9ancKDA3W2Dog2YjFE5Ro2B1x1/XoAa5yo7
	 Asd94m2wMEkIXn9n6Fogb+DrMScBBi/r5QQt0be9Rs+dgxmEiZoNASHFFGLGKfGjIs
	 ZwIj/UCED56IEsuDqThtUao+dEnQjqXPnW895SdHoi1jbgv887NK9O5ZfmFZycUSmq
	 PeQm0VLBfHf11zwcmBM46J1V2jF65mJW+cYiidZxc8+aUiShkZd7IOB8wHZl/M7BEa
	 vaWQBCW4AygAiwCBuDZMFLxGNdQmgQeu8E3xQM+wBczNrI3eNwBPtrGAPZpuidOAuX
	 RzDMCiAaFKoKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code coverage for CI"
Date: Mon,  4 Nov 2024 16:28:52 +0800
Message-ID: <ab62e7d2f50512594416acb973dcaf3d4ec85fe3.1730708911.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When our bpf_selftests are re-built, this error occurs:

 make[1]: *** No rule to make target 'atomics.lskel.h',
			needed by '.../atomics.test.o'.  Stop.
 make[1]: *** Waiting for unfinished jobs....
 make[1]: Leaving directory 'tools/testing/selftests/bpf'
 make: *** [Makefile:259: install] Error 2
 make: Leaving directory 'tools/testing/selftests'

In this case, I had to remove the cache directory .virtme and recompile it
again. This was very time-consuming.

A workaround patch for this is found in [1]. I don't know why this patch
has not been upstreamed, but it's in BPF CI environment. I think it's
necessary to synchronize this modification to MPTCP CI environment as well.

[1]
https://lore.kernel.org/bpf/Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me/T/

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9ec53c858d8d..64388a2fe5a0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -652,6 +652,12 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TR
 $(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
 	@true
 
+$(notdir %.lskel.h): $(TRUNNER_OUTPUT)/%.lskel.h
+	@true
+
+$(notdir %.subskel.h): $(TRUNNER_OUTPUT)/%.subskel.h
+	@true
+
 endif
 
 # ensure we set up tests.h header generation rule just once
-- 
2.45.2

