Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5E20E4
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 11:23:53 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id m14so13411362wrg.13
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 03:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SnZUDOCHMQVIhlEB+bu8TiB0jmIpwU9lc66itOumz4s=;
        b=sikAKJdS+EeKrqmbe4WQxICG+fSzFqoNnAIjkVQKrHbAPEzmIwX9a+5rU70OO8OR5h
         fo+FykArKI6EnAGK2dKLE8DD9EJzDCm6jQNDaMSuJ6spLrvMNUjH33IzSsvBjIMQD4CC
         CWPlO1PgnqKve7FiV562PbX+CQecATWjvMLLXzWJRZ8SSkMvt0g0evxCY7n6xXcXDnao
         YEXVeWtFwUrBJD+KozMiTs/6eAvRmPni6ynnilKVfYcFykmmkxMZLxET6ITcAKbA13Cj
         EJ7zAbt3dXoXjbP8B6AcJOlhCwEMC7SSiNArM/p01i/d6oe5aQrRML4b0DSPDP3hSGcj
         YVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnZUDOCHMQVIhlEB+bu8TiB0jmIpwU9lc66itOumz4s=;
        b=MtciCVseCjAFYxspNwP4VeLvdwd2ZnrQBe7SyAkjpxRY8JotXdbGImLJG2yPEtMJzf
         mEzWsapGoEOqK249a1cpB6aDCHmIHW/fzxLkUhoyvusKY1fP1bYEqH+YIhh7dLFqHHXo
         LCO2jkATz1nIaE116I0JBARzQS2+/K8HlOS4Yowepx3o4GCakVVDAHjT3E7xetbpwE8i
         wBF32q58rQ6HdKBpok7w1zQfe0qyzdZBD8dU/Y73sx09QTEM7Ll+gykIqhxD6RvsOPb/
         jlNcZdoy3M48fV20nlHOb4t/bX3Qav87k9w4iZ/3f3/Z+DN8/UasGaOcRNABxsVERDXm
         4O1w==
X-Gm-Message-State: AO0yUKUJe+6q73/UgRBIIcaZFohLv/YHupShDvAaAbqxfVTNekNOIAZp
	08+9zm3BoLvFl58TPC4EMY3Xrg==
X-Google-Smtp-Source: AK7set+nKFQODiLmdRx9Rb6zqH/L1J4AEgPYKgvpBPDJ7c9sCVLceMbAOxYcYfHmHr1LbfkC748Kaw==
X-Received: by 2002:adf:f045:0:b0:2bf:b872:cf29 with SMTP id t5-20020adff045000000b002bfb872cf29mr20243112wro.2.1675164231660;
        Tue, 31 Jan 2023 03:23:51 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4a81000000b002882600e8a0sm3140503wrq.12.2023.01.31.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:23:50 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 0/2] selftests: mptcp: stabilise 'endpoint'
 Join tests
Date: Tue, 31 Jan 2023 12:23:28 +0100
Message-Id: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADD62GMC/yXNywrCMBCF4Vcps3YgF5Hgq4iLNDPaEZuGTBSh9
 N1NdfmfxXdWUK7CCudhhcpvUVlyD3cYIE0x3xmFeoMzzhvrLc6lpYKi+mL0zuNjkYzET26MlTE
 S4THEQIHMyToDHRqjMo415jTtVJvLvpbKN/n8ri/wVzM3uG7bF532NU2VAAAA
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=CgdfmL4cJJxY1BmSTrXPrny5BoyKMqytq4mD4ORmX8M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj2PpGqTomeXNWno3cNLdYLUe/6iP+Yvrusl85I
 mN5lV3OXiiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9j6RgAKCRD2t4JPQmmg
 cyNWD/49OnFouIhXPIRFb5IAYxMx6IWvq6okBkG92OJvUNvPA79VMimLtaBb45+cf1BS8TmeuR9
 p41DjmfgYaHmlmwEnNl7drtMl8cUTY1CB+OQWUTI8yi9eGFr/5JPI9RnuVOYZOGbLOD4kDA0H8e
 +4Oon00i0Y95oriIkZiflg1FjYOk4A6zmyWzdJuIXoivmTfc0gw8iscv+Jaovh8PCCSSV71yxY6
 EZ69xWCoOwIwYsVXdyxI5LKSO4QiedNWDnN+ruNFKfGTnGo+J18iGY0PIIhm7DZSMfx6lb5cM+W
 6O23QkVbDkvFeJcy74MGn+MVxb0vGzlL56XsukAFUvcQaD+L02I8IiaI6E+JVJsFZeutavDCQBx
 tXbh5e5wa+f26Gfi2g3bM/Uv52Lg1U4I6qfWEoLuiGLypjb1lPwBB14RD3vO2dXu+wcgSFL/ylW
 5D1uqPiEl+cIzEJIoNe4i8AEj0qnHPUQFgPbsgZnW7NKHUtRCR8XfSzt0QQj42MmI2iWWcQqp/5
 q777EoVBibmf9kQraMC+ZH0ht3Soa+j1aT4jA9aIVpQjcriqgdno+oQI45Xe7CjtyMKg1HYZYVD
 uzVwpOtNIO8hQbcISabrKGne0zv9M5UfyL7b2DgfZ3mew+OTPTPjyIfhHnZduDJ4zNMOhRoKOnk
 VyZxTn79eKjbQ1g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The first patch is the one of Paolo where I only added the
initialisation of "dump_stats" var as discussed on the mailing list.

The second patch is also somehow a fix as it stops the test earlier not
to wait quite a bit of time for nothing. It is good to have it now as
after the modification of patch 1/2, the waiting time is longer.

To: mptcp@lists.linux.dev

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (1):
      selftests: mptcp: stop tests earlier

Paolo Abeni (1):
      selftests: mptcp: allow more slack for slow test-case

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)
---
base-commit: 0825e0ffa15862dc5c95b2195656f250a47be8ae
change-id: 20230131-mptcp-issue-323-join-delete-re-add-48a8d8d06120

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

