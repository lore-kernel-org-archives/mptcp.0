Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059DC0B4
	for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 16:05:29 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id bu23so16171284wrb.8
        for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 08:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV42mF+MU/yNNSvEQ3cDck0zrBQnXXK1gKwku8LNjTk=;
        b=gy/5cZ2aMrhndW30F+FCqaYK+HxAuA1zxnPhxQFUiywLxOjmNP3CwC43CPdfr5BH/v
         T5SUWAnNZxQie2Ft4qQO25+5nntY/7fgnoOUfqwIo8MBEjvp6R+7kjvVYwxca5Zoyq1W
         Hh+0sj/ih+pLIZGOQ1Gv3ideoWjbJv6hGThumetKQL9SMhm8NydCosYx0AM8DtJSkLra
         Iz9H8AVRmev9rWw7s5Wqnx7n2Kjg2pQ4TBdm0mmD2S5tF7AGVYFWQIhWZwo9SpKBRQ8/
         z6bvcVM5GmyFUDO/k+dWvH27WLa1GMeXD4UkidOiW1W5dqX7pZcRz+vHwyO3QhGXPvbf
         OPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV42mF+MU/yNNSvEQ3cDck0zrBQnXXK1gKwku8LNjTk=;
        b=4LqKunSAFYvn2JVfQ/79UZwhc96SL/qH0TSzjEZbtOIs2Cu3p2CRZJlD22ZvBr4lAu
         iUS9fvpI+uyjh0Ny5yWkqu/0f0GuCo/Ra+pswK5Z/FcF2/BHmBjS9pBJ/AqufdYhI3iJ
         d3adIqQRYt2io4VMyde+VEBIplvrVf7ILGzkrsCkFXFyaCEXFGdwNLXCr8S0nO5ZTT9l
         Pv1R9alFzifZRtTbWK+SRoVrKKrSwA4uzUtexUf3QxRYTeuXux1PVi6a+Nn7aVBUQ4Nu
         Rcrh1dhfYtBIizhaBws7a5R2Lc4UYyHVhSi4BZgQCK9a1LGsM8T9mfhrXx9CJlQLkcfA
         rKnA==
X-Gm-Message-State: AO0yUKX+O2b/uJyBWu+t0Ei19m/jCo7Z0rgROhZXAQMNXUqUub1Mv3vD
	no3KD6x2AOsXrMnr77EDdEEnIR1aWq5ItNQEhPy0zg==
X-Google-Smtp-Source: AK7set85EfmJ3xaVxXEKcfjUrXPWb7MiIP1nWM0eDC4AkvRs+E48pEpJ7TfTYo/5FNO83tFCSsa/2w==
X-Received: by 2002:adf:fc86:0:b0:2c5:53f8:4054 with SMTP id g6-20020adffc86000000b002c553f84054mr2348438wrr.51.1676390727983;
        Tue, 14 Feb 2023 08:05:27 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003db012d49b7sm4435537wmb.2.2023.02.14.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:05:27 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.1 0/4] mptcp: Stable backports for 6.1.12
Date: Tue, 14 Feb 2023 17:05:06 +0100
Message-Id: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADKx62MC/z3MSw6CMBAG4KuQWTvIVHDhVYyLUgZpArWZKQZDu
 LvFEJf/I98KyuJZ4VasIPz26l8hBzoV4AYbnoy+yxlMZS6VoRrnqEnYTqjJtiPjfxh9mBe8IiE
 ZFEc4xeQi9n5hxa43tW36mqghyHZrlbEVG9yw64cl7nwoJZWf/ReFf0A+3SG38Ni2L53TAkm0A
 AAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
 mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Mat Martineau <mathew.j.martineau@linux.intel.com>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=pbuAhIx9yE2zwRo97rTcHGLzAnrJnbrf1fjkhlJ0qFk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj67FGKipTFMqr7vbOLouBGnvBW4T5lL281Bsb2
 MeT+8OUEI6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY+uxRgAKCRD2t4JPQmmg
 c5CHD/0XLS478ViEGLXstLJLS/TgUp/i1F33SDHjuM0V1mOCiHQgbMIyP67yF1Qgqzins95JjKM
 eI0IMUn7EtbL+QZSB8PZX4xo+szL/EkS2bi9JbP3GxyV2nRiXnSWeTJp4oXOsIzOrGjoRIlGkkd
 bidEeR8gAUTAxrQnwQLLX11jiqTVbICl4op54VGKQbDMGPBe5cMNtGJr4JHGMTvtxA2vV2DUTxI
 CIZ6TvQocUcSVailPhgMeenlBvc6hneSXQ9KBMgAKEUMusLNUR60/VcaH+R38Z+XNyshWBuTU/d
 oA/NXOHjpoWGld/T/n66/JBgDM06+3YBk1MsneI+6v/eHiN2Y901d2cdP8ZvlF7MvTsLAf7COWd
 cwBP/NxslP0xAT+m4bPovPNiDSY1yc25dlJr6ficIQasTduk27V3OjSzihz5XhLX1cwhwDlQA1V
 TD7gLC2NNPfe5Fkh4Tzv0PglRkHHGF91AUctI1GzDT+wEZSmdQsHeJdwlJ61NFNlIuhrfPa5jmU
 xuR5N5PubruEJOpod7LuNFhsRaXOjWP6vRcTMuz3TN5WE+GH5mqekDd1Eq1Tzm0TucIMXdjg6mR
 ZfsxPAuTneLQx8ePKqzxVqiUxoDHGurUWQy5g8Y/AMA+OtZ/1WkWROiDd5BWJrTYnhuQZOlLyYu
 kl73EZksHOOqVlw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi Greg, Sasha,

Here are two MPTCP patches backports (patches 2-3/4), and one
prerequisite (patch 1/4), that recently failed to apply to the 6.1
stable tree. They prevent some locking issues with MPTCP.

After having cherry-picked patch 1/4 -- a simple refactoring to make a
function more generic -- patch 2/4 applied without any issue.

For patch 3/4, I had to resolve two simple function because two
if-statements around the modified code have curly braces in v6.1, not
later, see commit 976d302fb616 ("mptcp: deduplicate error paths on
endpoint creation").

On top of that, patch 4/4 fixes MPTCP userspace PM selftest that has
been recently broken due to a backport done in v6.1.8.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (2):
      mptcp: sockopt: make 'tcp_fastopen_connect' generic
      selftests: mptcp: userspace: fix v4-v6 test in v6.1

Paolo Abeni (2):
      mptcp: fix locking for setsockopt corner-case
      mptcp: fix locking for in-kernel listener creation

 net/mptcp/pm_netlink.c                            | 10 ++++++----
 net/mptcp/sockopt.c                               | 20 ++++++++++++++------
 net/mptcp/subflow.c                               |  2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++++++++++
 4 files changed, 32 insertions(+), 11 deletions(-)
---
base-commit: 9012d1ebd3236e1d741ab4264f1d14e276c2e29f
change-id: 20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-df24a5f41151

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

