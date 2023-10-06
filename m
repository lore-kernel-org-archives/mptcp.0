Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AB18021
	for <mptcp@lists.linux.dev>; Fri,  6 Oct 2023 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0HkHiaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65907C433CA;
	Fri,  6 Oct 2023 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696603644;
	bh=3fcCkhAMqz+B3I6N6A+aPBPxKdvX+PKIKTYR2gNeoLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U0HkHiaY2zrqgwm3NGEgmNnxUoe0fkHr/m3QF7JTp5Au412xT6AOgOCco2N6AdPe0
	 IP4B+qzjglRa8a4cgnZcgDIXDebGe17rkVkAvgQnHvvrwZvMxPXtt8uLZ3dwCg9Hib
	 EIn5d4oChvjPDrHcD88tVal0SM9PjBOXqj4YjjPwoFqopAsD1wIj3SDM2vIUq3aNPK
	 OEfPl1VSSss4uUsBZshmFVmnZSbqCMVo9TIlsliCg5L5iK4cj9qFBHG9UBPoUmOxYU
	 uuKCfzd8AJ1m520TbkaTmEYyvYQ3j8CkLWTVfOLmN0H/k6YoEPbaisNzQsvJavcZB5
	 EcWhl+jU+ROjw==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 06 Oct 2023 16:46:36 +0200
Subject: [PATCH net-next 1/6] tools: ynl: add uns-admin-perm to genetlink
 legacy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-1-0a97f2f5410e@kernel.org>
References: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
In-Reply-To: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OlciFsOMezGCfcpMdbn3iwfCcmCBig8AbhTZ5AI30SI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlIB35+gjir0KSpcrtluW3QSFSmeGqG6trcxzPC
 1gqfdYyVMiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSAd+QAKCRD2t4JPQmmg
 cwTwD/9VMGAUtcyKPyyxXwgNRGdS5XqZ+gE6X1UR5Yz32AFQosnFyvkvoW2fTpNcIXWEWbLYpPJ
 KHpx6pK+ZJvpBeFQ/Ptb0cJwgPGpDpqeIl1MVVFbhM+EEJ4d/5ks/jJpjZfcMaOVMpaTMBW6V1M
 YEF4qZCy0xaEi4RQhKTnvde+SOrgNideih4BJUui/jcBg2qVbjOksZCSQuC2bzWiVglYEmI929Q
 50F9OX5aNcYf+PywwVG+H3Ks/JLrV/OtTgbOUiQJUaYqUCKK0sCCrw60V14XQ0AZVyb4npwDZsM
 m6aZ/D30gulw83y/BQy2hq+8VcEQR22iTbecVjWyZq0B0hp4uGdS6RdKE2QAciyWYZeIChkF8A2
 MqzwnxreXnNnIc/8/F/9vDR3ZlUEjyAu9LM1GET9jaqSWZ0caMTTdStoozFVJRB57bAsiOZk7Dg
 Iu8f/qZPtcW2z12YJGFJ0Ed55aa3QyQqt6E2gBo2RWZ1u8dRSwcn7o6jtDxGEHAPr/vzH+SAo2f
 QVaRyN7rFNOYitBUdktlinOxhm/9EtVAM0dEpRO2k8EijWN/+nl5Vb1TMieXMuT1epUkjveZuJL
 +Q83pIEUmth1o63CnSOzwHICiYZnJ3Mjc3xezRbkSoolV46SWPCVPl43gWZmv3PQJF8NCvZW0Ct
 vFuwInn3CjFZaYQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

this flag maps to GENL_UNS_ADMIN_PERM and will be used by future specs.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 12a0a045605d..c08e5e3a0aaa 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -316,7 +316,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array

-- 
2.40.1

