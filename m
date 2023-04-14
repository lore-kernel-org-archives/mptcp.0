Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA6818
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:29:45 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso11549220wmb.1
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681464583; x=1684056583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0FiwgBedTDUBoK09RRCPvT7bFUVb5H1278iVDs1I88=;
        b=XaDGaOHTv6cVu6IGeLcb53BsIMSvTj61dDOWn2jQAOg0mivVjx+4HS8rEGhx6f4jK0
         vwy2V3QQATO2rfssT0tmfA4xINsUIh8T7mmrJ30e2NuWIB0HkxpT7+9ihYqhlDFRxcRG
         J5IL4rjecFWBarJtkNcuD5mce+kb8LfzdhSVqhew8q/gcKSUZW24JJHTaPhz7JcRA117
         2Pz3pSmlRWE/ygQmG6ieciVtbey3tkTCAWKHnTkrEuslKUlsnpkmPyIzjuK/W6claxcc
         OtY+3qs9860thtgIWUzInaSREyxH75S132hgZVyK2ifiHXOPuQv1m1BeU275mdr9Xcji
         MXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464583; x=1684056583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0FiwgBedTDUBoK09RRCPvT7bFUVb5H1278iVDs1I88=;
        b=bHgUh+w3pUTP+ubHrwAEgxqh9Oc6HPwB6gV14KiUOAyHvCHNUD5W9XRBKr2elj+dHG
         TOeJNCEtrnRgZZAVMo13272d3iHk5N6SFwp3SNFPxPqJXixKUB0RoqxDi7WaEJVgPEUD
         rbRGObDw839KzX/825VVALeIRr32qwUQ7m2hf1NGVW9jY2ASmuFSxjLE9X/F4DnAhAyV
         HDMU7r+pfmwpeNo/GjSGbbuIKX/Edr4NcnSrjnFnVonRaDq13THXrWsXOEvdUboHkZxP
         O54DCVW02Fe0+Jcz+t43hlIqKBAe6l6eqfxvNNTpR6h6CSglzS91YfZ5P7F0NmJ59zGF
         hjJw==
X-Gm-Message-State: AAQBX9ckYeYNXWvmFczvNR5SlFNkDjLP7I3LTSH4qXDbQqtFhGmV8141
	TxTyNqkY/CT9sOgd4sbcpm7qnUi3Kkndi7h0doADglw5
X-Google-Smtp-Source: AKy350b8T5BcZDk3izmrgDRNWuQfUjbi88Gr4qg6s1z3wh7/gAptZqyUjzdgJx2h10eMufEhJwQDrw==
X-Received: by 2002:a1c:740d:0:b0:3f0:3d47:2cc5 with SMTP id p13-20020a1c740d000000b003f03d472cc5mr4163861wmc.10.1681464583100;
        Fri, 14 Apr 2023 02:29:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f09d51a4edsm7620035wmo.48.2023.04.14.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:29:42 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] mptcp: bpf: fix compilation errors
Date: Fri, 14 Apr 2023 11:29:32 +0200
Message-Id: <20230414092934.4065227-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=642; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=hgeXvgn1G0m8aFc8e0WBeox3RAPdVeDfe6vXwhxPShE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkORy1wkv07RbGcaLFAoyuGJDA1yb0w27yP3dEW
 S8XtAyanqGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDkctQAKCRD2t4JPQmmg
 c075D/wJWtJzeORQU6c0RhYyYpwdeKfIuyiYYYVcHtq3wgyVvIX6MHYZAPS18tEcHZJSSRQJVi1
 /OS5t2+i8gsQFQG/DisgzHdLWaAiR4vcqCSyMnckqL/0MHzFisz8KxT4tjV0buVStpsagrgysSN
 0H6TI/tWg82zfqg/vnGdoBvsHW6nJeZ71/CInVlTo5DHK2yFD+YYcsqNPqrobxS8aDNDsDFacP/
 7sfYvkptTfpAtRuK75x1JLtcCFfiCYiy22xhNMJCG3NU4NLTXh3CG/n9F7wOT8/Nq9nHCLjlC+k
 gHtMggo5C3lpdBqgdrUxbB6vYR8a0TI0rJOViy4yPtBw2p1mvhL3P4q29lrPPcpFb1X2GnQwU0Z
 lF01MdX9KghnO/e3rcP5gxpT+mXSuuRtsPNt6QmG6kEjTG2Ab5E06mz8IJF20NZ15HH1lDEWlS8
 sjMq6qUh/MxLBCvuV0iYHfaaFbp5doXAyiBWw8mZlGkz4e9GcAJehBBnSIuP2mJWPkw1cAo3GNB
 +t4pInx1E2261H/6SLlQeIXf5pWS/KtWKx7Mwi5Ij2QajYRxiIy+GC7dZUpR2IESCfD/VZpwLFF
 87R2oBcZi+BIt5p5qq7U4ZyqwCXGvlkALE08XfRrXOT2RIt9UiipIkgl9ephmaxD88apYu7uDyK hTLHxa4Ii7/x2ng==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

After the last sync with net-next having new features from BPF, the CI
spot an issue with our BPF code.

This should now be fixed thanks to the two patches here below.

I suggest not to wait for the reviews to apply these patches not to
have other builds failing. Still, don't hesitate to ack/comment/reject
them later :)

Matthieu Baerts (2):
  mptcp: bpf: Invoke btf_struct_access() callback only for writes
  mptcp: bpf: Remove unused arguments from btf_struct_access()

 net/mptcp/bpf.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)


base-commit: 035d5d875b5d1f2f2da9e777f8ff5c7f544b76fd
-- 
2.39.2

