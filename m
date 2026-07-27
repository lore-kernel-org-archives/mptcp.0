Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5F40099F
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155862; cv=none; b=ciaQh69Z6DlBIKCKwFtXv5U3If1wxtMznujFHlzjcunBxUaDgTJeV2pufeoK7C+H5qZ9migbfIDDIzAw5o2hC0I9lBbahAURrYqTHwcXb7Lk7/Hj6fqyqnxOt5UE1vs0tNq1eTbln3fZ7Ew+/4IpRwAKBcaidQybBIta/XnAW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155862; c=relaxed/simple;
	bh=aWuqhw4fqBA5/OP78pKlvEdGL7M+Qk8VuIeKHqNFboQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PQDzK0IqeahfcG2TeFACK8WPEs3A/wJM5JETvQA6DJ/23vLMnssbGpGh4A8buvEH+U/1QP5W97J4oNtcKtAYfPd1N6ixAnVwqzFjRImXt93IpbXT4SYfopbfp3Z+3xt5VbMuLrQThckynGBSa9CZ0T+XgDRu+795owe6/5Q9OdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NysLfmcX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NysLfmcX"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c12614b81c9so447811366b.3
        for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155859; x=1785760659; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ujghzi2TEBK0PNLJBl4hnfDgbQkE/G6iwau+Gj0teSM=;
        b=NysLfmcX7U5jRqGtYXi+12fU9kCHBQjFPNCVnAb5wrzK/KTnyfAzFMXCP+FmWs4nVl
         xGlHPvk1d2kMbOmh5IT3GUPlnFDReftW21ipfyqqNmWG1W22VszvEwhBgXoi86WCNhdv
         MtUe+mw1nKzK1hRT32CbGfW2C6RzrqjzzYtfIR9JPi2fYPLWHl3dFAaLrVwtYnvZKEvt
         ezdi7rl3SEcT4XGZPp2hLdpgP5qZk84urXwIvsFoQgy8GXsKuUcYuQZ384J1E8FwGdqP
         i6AU+q6kNBUey+MZKQe9iyYPJQkAnFFO53V6F3FKKNdVkaLcXbpUwdUXfk4fDaDXgjWD
         YTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155859; x=1785760659;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujghzi2TEBK0PNLJBl4hnfDgbQkE/G6iwau+Gj0teSM=;
        b=oDeHgpP92tnUJmPc2aj2tdx5ROEmorCQJmOksUsPQiheLQtemtrb3uynDtNqXpsZUi
         EG2q92QWGIiEMS2zS28DrqDzYWr3bKX66VDEkFoib/TfY2GvRHB/VxD35ztOXm4WJnZI
         fiMk1mQBYaccnQQceZjBRYrS3bzAhkVz7rjOWWiw4owcmo0VKXJ6k+spI6Xvpg2wr8CW
         89br29+KXTe1nrPDNg8siNojej7mSb8zGNXsltN8bWSb/zFklsT0sZexwTyM0FOOGCiE
         nFTYpdPswa6DEcTAA8Y/j0lPXVTiPNNLSOkgRDuh875ndUgv88gRqa4TI/t4zydSqzwl
         R/WQ==
X-Gm-Message-State: AOJu0YxMWJyN+iq7pX1mbh2dWt82JG6hmpWh4WO4yY9HwN09EfYf1hHv
	+AM7MV1nsH5ayoBT3j1jVcEGogocu/haz5K0h7JLovVs60Uudpyx4VNml4Um
X-Gm-Gg: AR+sD13iXNr15w0FwCDiP2s7AFqcMM5STw7I8oJ0Y2Q/04aMW5fjo6arDlv8N9FNVG4
	itPM/QFQZLd+gAGExlrOjD1tyDzV/X3GAvlGCYmvERhy0608Qvi79qVRuL1eslxm0LT0pPXPQ6d
	7FKQHhAuAOejkwiVIEHRDDuGPQH1T66bKZ4jb7Xu9bd1+Ubh2Z9jZiQzODzFwSMHKU4GWKnHtSK
	7q6I1KEESboRENp0eYUVe3HLgvMz2XFztKVPVvdgshpfTCH0Qz204oq97gJQhqpCKfuqMutx3gZ
	b+3Eog+VligzKZT6KvyipRaJixkVTGpzD1iuk0F2j/s7cD1Sra+q9oCwyv96572qFJadJ88A6lC
	wpi5DaB4NZQb8UcAMANUlXmxW/yHCDWaOfNJ763jiSB7aFaMj3Kh0e7fSrZXXiogcILQywNYMI3
	V97vpQx7HU939Gdv8=
X-Received: by 2002:a17:907:a4a:b0:c15:f395:ac31 with SMTP id a640c23a62f3a-c1f1f3e5ddfmr376722066b.61.1785155858345;
        Mon, 27 Jul 2026 05:37:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.131.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb98dsm634744866b.48.2026.07.27.05.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:37:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785150300.git.tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] Reduce the differences between TCP and
 MPTCP for TLS usage
Message-ID: <9931b657-6baf-cc93-6cfa-a46b548cba23@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 12:37:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/302635=
50148

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/08f9af979c9b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1135094


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
