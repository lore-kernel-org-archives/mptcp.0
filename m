Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6E10E9
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885729; cv=none; b=s67ckj9lBgSU3bpKqieXRgV6q2I6jEb7RtCtzadebePkgNv+310JZGs3EslTi2wOGCJs7YvS1WN7OLLsRae7UxSeil2IXcrLEXnlFuixOxwSgh/Bc+CZsNaOHBezW58gzVHEWE+x6LD3hhNY4uXbvVC3R9NIeaKNRxqZl7RyueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885729; c=relaxed/simple;
	bh=ts/qmYfGj6+MsR+Lq96w6xyInlK5eHlzfZg7xDVVPqg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UBH6pwLrb43W2o4VGjQ3fpCsoaTXXSRWNuPHRgLijHMUU+Y2401n8Wdmmlvwx/pVmn+JuRzrPAdDE9eEP7FDopkAhCHkIjRtYMFsTNMNBkOaXBkdIesjUDgU0+AZDTJNra7j1WtYIA9s+Eb1CnLdxEUAk4Hoce13Dy8BfAFMCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBn/+hQ7; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBn/+hQ7"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e033e66a31so24786b6e.0
        for <mptcp@lists.linux.dev>; Wed, 02 Oct 2024 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727885727; x=1728490527; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bknk+ttNOrEuOn8z4YglxzUnPjrVvJaB6387pEdA44=;
        b=OBn/+hQ7SnTlDBqMRAKONYYqcAS0jx52gZaICW4aGY5/jmB6O133PMUc0prK/RtrVi
         q86srrWnroXPn0+inuPERXKeIuPcC/paS2Y/Wmc9SQEI7+FOcZUnlkH8qF961wBga+5C
         BelYeMKTiAQrmwWmhSMTXs1Gx84CDI7SsG00AHHVPFh4ODByy16qxsCTuAZbWZwqPwNw
         wgHGDujYcvEn5gMgq1izkVZHFdnv0SL6SNdxAdlXHzU3CvGLU/yWyxsIva/yYTfcGW+w
         d8rUsLcpvqkoM9WYHzaWu8E3X+7HcSsODUsSHJeEWvztsl8zpw0YS4Yx/6zlOA4IxfW+
         gJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727885727; x=1728490527;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bknk+ttNOrEuOn8z4YglxzUnPjrVvJaB6387pEdA44=;
        b=pcrtiBmTYjazOF1Oz9w4O5QwyUxqSn/1hSnqY/ELpTX/OWErppSu+6fgIq4A7UsQuU
         BYI3+tXCkJRB1T0cJnqJEFqp94bkQXm/GHwLs2w4bEoIkleSw77r6X67m8OPnmjj10Em
         FFtcXwKkvHY74vwqkvN8Y4o2zE4FquKZlZqTAQA7jk/LXoPh2BH3AKNGQZBZAd4ybV9h
         DYo0EK4tZY5fVsiTrJp9RrEq05BKhupHbcHHxY+9ppPtyk3AFXEj0jCmzJCdgM/IQnO1
         /SDOWpkgwWFYVdeSCMEd4RA9y4wG9yg4l3zxDvPcw8TwxTZPRXbjIisWr/a5NUBEaJDu
         /2SQ==
X-Gm-Message-State: AOJu0YxD9nIMW2wF9K3hT6qNq2m9Ot1SBsYgismaFHc/pvz0dxE4toHx
	4DLeNaD9p7EuxfmSQvOEpSzpXtDsG7s3ha8dbRr3fZE0V0OebKs=
X-Google-Smtp-Source: AGHT+IENmsWsOc0uDlNWt/BWY1eMLbgNfKv0QZY+ZeHIzcvexHmhuY5t+PZI6hWDbrtHZCIWzvBDtA==
X-Received: by 2002:a05:6808:1984:b0:3e0:4722:cf8 with SMTP id 5614622812f47-3e3b4129921mr2607979b6e.25.1727885727066;
        Wed, 02 Oct 2024 09:15:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.7.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db292ac7sm8873530a12.7.2024.10.02.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:15:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dfce01586ff42d63cffce0a2ca10149e30ec71fe.1727881810.git.pabeni@redhat.com>
References:
 <dfce01586ff42d63cffce0a2ca10149e30ec71fe.1727881810.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-net=5D_Squash-to=3A?=
 =?UTF-8?Q?_=22mptcp=3A_handle_consistently_DSS_cor?=
 =?UTF-8?Q?ruption=22?=
Message-ID: <1cbee6dc-6c2d-a3cb-a064-49bcfc158cf6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Oct 2024 16:15:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11146671727

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/878435d35384
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D894880


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
