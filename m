Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C982F31
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 05:32:44 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id b8so16134533pjb.4
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 21:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ftNhtgYF7KIL09ttTCc5vwMwAPihPBpeH/fVxXP5icU=;
        b=K9bwsYWYOqudUHeeU5qixfttzhHcqSZ9pfJbaoyW2BPzXsm3Xi7xZSKZDfgQbWbOzc
         7gKTwUKs3xFaIXgTYj7iAdMKD62L6YuOoMKgkqHQGRXf5UuWTWVjI+6eyZBuGN6jbZUZ
         mM4e7VMoWiXQElO0rhURC6ay0DLzHJRSUrSBU1CrHu7fejN9/9CeoElWip7TIv0pCms4
         MieHNBIywbqH/4Fbq54QHZ1rW83UC6oDZwpIc6ibqMkboqMLNBqOLdkIv//tjxztgIce
         ieoGze+bddQXzhrCf7DTt3Tu/47fHS6wushziTUq7Ezcdwr8uVHEoy6qF6zBpOv8/vji
         cTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ftNhtgYF7KIL09ttTCc5vwMwAPihPBpeH/fVxXP5icU=;
        b=O+s5/sDRNxVRA4A9+T4hbVxnnI+TTWPD9NcSpGLrQlh7zk8jZzyDFC9ohqK8gW94kV
         toDAQNjvVjwdYfJ5bYBJYbSQ8eFs+Bbtg8hmQbE3astI6jeWJph5IBvMEMfMHfyViySt
         YBSDxCV8n8WjGMXS5EaPBaicCyNOyIc51veb2jjj2wJdNSlBApmsLsz1ywgJC6YKvlnY
         8jpQvIH7zPkznofMRtukQoXe/Ue87NMCm8wwcxhCVCNJE5rpsXUXT8NO4xCssVRiWn/j
         TOJZSPmg73niCZnkgWPJYByPjf3ZHPlF1q/wiF1n+drlVBxDItpN4Vk7IjbdWhonrr7E
         Gbtw==
X-Gm-Message-State: AOAM532gjyrqG5dcgtty1uhFJVNxglm+/Q+c5pS+IWpElBBz7+0ga/F/
	Ery1X28oTsM2ePfYpjSz1Q==
X-Google-Smtp-Source: ABdhPJxOd+CerNMsEul9U5QpeqNJ/mFD6uCOxWJ2GWsiyO3Pa4K8/h2TyyzObrQ2IP+a76v9AbEvRA==
X-Received: by 2002:a17:90a:cf87:b0:1bd:3595:3ee4 with SMTP id i7-20020a17090acf8700b001bd35953ee4mr2867379pju.100.1646717564077;
        Mon, 07 Mar 2022 21:32:44 -0800 (PST)
Received: from [127.0.0.1] ([13.91.165.54])
        by smtp.gmail.com with ESMTPSA id q15-20020a63504f000000b0037425262293sm13356006pgl.43.2022.03.07.21.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 21:32:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <522733c62616c526a072ab5f8bc211efad1bbd66.1646711943.git.geliang.tang@suse.com>
References:
 <522733c62616c526a072ab5f8bc211efad1bbd66.1646711943.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add skc_to_mptcp_sock test: Tests Results
Message-ID: <7e623498-f8ee-e1d4-2c1a-89dcad2a50d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Mar 2022 05:32:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4692010903797760
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4692010903797760/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5817910810640384
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5817910810640384/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/eb83e0f5a1ff

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
