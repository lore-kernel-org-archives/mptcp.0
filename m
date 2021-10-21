Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702B72
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 06:16:14 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id n11so17783535plf.4
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=mrxP3APrKvjLKfXs2ehgB0Efg8NiEEhBsCsLhm8El8E=;
        b=fNPJoiYT44VjgTy0knba0gWuKkDPq18VvNRB5btPru/4MkUSGGRWh4L+hiTfTVUzDx
         YHj09wfmmzoPdRkUO3eZ+DbCk+HBqu42+bVhypmfjjU1rqAw5TreivtHwyOYne/agzrF
         UJc+MNAKMYp//KY151Vsav5VjWLKNesFsDRoK5QYZQeL2pMCjKiLV5XANfZLEZzOY/CO
         Po6Cm2cor7zIA5NxQ0+e6RaLkpqxO0BlI8/iiI4vkWRrc45mOUBQeOCkqGIAqpLwcmDF
         orpv9LlF/2Ggd4X6nVztK7NvAyhTnB5p5r+eto0Ozh+qnpEimxjinXRJtbcf+D/zpglp
         1Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=mrxP3APrKvjLKfXs2ehgB0Efg8NiEEhBsCsLhm8El8E=;
        b=VwD0gMSmHGt/oM1K/kpIbQt0zi52oX7zPhBu0KH/Tm7lFjO1IxXSlMRp1Ey4EMGA17
         VxqPZdTwrFYm+wxmCJMXsSQdd40/63oX8296ufYTWZkhXZSRWH/yHt5mDbJscf33kvkm
         QT09fvgHvrq/YfjoLLNJxbSX0uWPXgO1pzh9wUEVMJ57goCzqkR85JDri48Bol5hDyMj
         ingvPGimLluWMr56jtnFJJJMJ1gN0DyH2AXWZck+XT3XuJZkIVgxKdMIBph/KRqJXCgb
         Sb+VBJHCpJ7dkraW+ox+ZNoc9ZIc/dSzqHGYKOw9gLX7dSiW/U+EBa+s1n3K9pYtClSL
         5NTg==
X-Gm-Message-State: AOAM530UaoNs7LETEAHTw2toqe6MPkDqMCoPRLSV8XWHQ+djeazFb65t
	4bm5FFKkn6o97RLBexR9rzHCd6ApwA==
X-Google-Smtp-Source: ABdhPJx0gteEBs60UcdfrBZukQ7Sumif5xoB4QsCEpYbCL5cxt8ysWcQbNW6ZjEkdIkrc6OhmGYGPg==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr4204517pjb.15.1634796974418;
        Wed, 20 Oct 2021 23:16:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.112.32.71])
        by smtp.gmail.com with ESMTPSA id s22sm4408152pfe.76.2021.10.20.23.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:16:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
References:
 <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_infinite_map?=
 =?UTF-8?Q?ping_receiving=22=3A_Build_Failure?=
Message-ID: <d4f7f2e7-c837-c5bd-a6b9-da4a74ead0a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Oct 2021 06:16:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/1366659456

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/895323b00a=
78

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
