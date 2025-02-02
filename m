Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD591DA23
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738477277; cv=none; b=GUAklpcsJ37+SuS+fgpo97aORKSimwRyNNGT/i8P77ymv8rZl3Dyt+q/7T8g18jfgyJ4RbH3ECR/hSXekGLXGSaTV+a3gYQacrN+Rcd4KSuSTsypgroUlgQ2XqQStH5rXlBVDNIFYGIJLPv8cYyxYZLkAWYZqImTD0sQkrY0VDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738477277; c=relaxed/simple;
	bh=X1hDHHV95hUzOt3XiGXrKn4xxa9ZaxGjoUL9RNJOu5w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=j8sbDNGwNfCLsHUSmXE3XwXRGKoWRGdIMwYL2aCBKhlsChzSxG8zuuiNshULgrx23HENKuXrwmjh/q5ejS4OK55BvHd60nPMIP/3y40377/4nYqnQSYLGOYQ++k75XIAVxkoTuBxYLoqeILnkHEuficRFFQfUJnR5q9igI3q3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdDF5o+1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdDF5o+1"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ef047e9bso301621485a.1
        for <mptcp@lists.linux.dev>; Sat, 01 Feb 2025 22:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738477274; x=1739082074; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I22b4O0uszkwmrFhBnN8g1XfmEhSB9kuCOMSDqyJCgA=;
        b=PdDF5o+1cA7g9b+6QQH32fQy5meZA/VUY0ifNfzs3UAR2VpH1VOiKsJw23NJdnIgzR
         dlyJdA31u7zxzJgeVyZKMbH2cZaPCnDu2391eDiageSvaEkn10Fb1uqH9bXdq2pfIZVi
         ltlZ0tfZILmMIJrNaO3MB20urP0dP8MBSJdUJ+DQBRaaJGpXYNpFMtLAdehGAvaNRzVW
         3lWKFK8EPgSimLtkmV8WnHLN0IlldIwBgS9XT/NiOdJYd+qcMEkWjt/CoDJRtAgcSuc8
         gCpA+5VgDzYQhd3TQt/B8aSiC/hbRvwXtof9XvyUv7Jt/GfFWOdKP7Bj/OGyU/m8KSaN
         gyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738477274; x=1739082074;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I22b4O0uszkwmrFhBnN8g1XfmEhSB9kuCOMSDqyJCgA=;
        b=oefU9lttvtonOLVYFI2GAT8yBVQkZ+RF23As45f1glJpNsNDNm2zI0Wc3zKiS8NaF8
         pDe/nNYL6nZrEDFeJ1qymQ5r3eQbOlEl1wH2oVAyvPuLECn+gUrEf9JpStMptIUkmZVI
         ZdhZC05Pz/guQWRM+fRIab1swAl8k1lRH7Uw3YhkC9ibvAQxQcjOmgOuTMwOl7Zu//Ep
         ErNaXoRiKI7Ha6peyW3KDskfF7+3vxt7js1SIkFBSmwym22uT6KTHIqW1f7ATerI6gW6
         PJB4+jEr3nFtkL9a+aQp2/PRrQLy8wRZ+QZsiAIki2VGtdPnBBxUcH6btOBGcmXXRpkL
         aZPQ==
X-Gm-Message-State: AOJu0YzvBVuDJDsPnlQCLIPG5bnRLbe3CMEL+PMbSCYbHJEmfycOBru+
	jl/lU5t2vK0OsYevIFKlQH7ZuKHTKqmrwDlHaNf9idQP3AsZh0EiM4CZELA=
X-Gm-Gg: ASbGncty0fwVtEmDezmIzpoh9YDYR7X698lwyc3VC+OqgGgUWiTpFd71zjWsYLjbExc
	PkaLAj34E4aCJ5sriOSWO34FegcMgvHHcvtFBfbhBv0/wUBmyQ5nAYOkiXqjEUhW2P8RWjYVbjb
	Vuy2Y5ozgZ1pAg+u0Vow8MRv721j2dqOi71xQ4hvPJNENMfzPskOQ9Ahm8hRfXRXiB0Hkfe5i2X
	rj2lLe/Xlgd+Pz0MweiqubyXLKLU7/hRUKw9kOFtZp4knvyrgh6IRGc+vzzCxBwwni+q7zix5ma
	wDhweqsQy6lVSy3CNar57NsSO58=
X-Google-Smtp-Source: AGHT+IG62Hd6ZKpgv1Zgx/ketaN42+B2HBPbtyskbW6QPgnAoUpq2eMH7q7UIk2jowDv/bS88GLWWw==
X-Received: by 2002:a05:620a:24d1:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7c0097b7d6bmr1789319185a.20.1738477274255;
        Sat, 01 Feb 2025 22:21:14 -0800 (PST)
Received: from [127.0.0.1] ([20.57.71.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a904810sm380556685a.66.2025.02.01.22.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 22:21:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <a0559064-2445-e68a-d084-108120106579@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Feb 2025 06:21:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: 1 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Critical: 1 Call Trace(s) =
- Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/13095733327

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/36253da54a75
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D929774


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
