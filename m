Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB1183CC7
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954932; cv=none; b=ozKznPh22lgLQkxYWYNw9C0z49XxEHw2fqW4jjIMEB2kPgJu4vP6tO9lHh3WVS51fjMXfRBe27s7fjVCTIeBZM4egW2OpPmTlCY3esQOVV4HtXd5ZPyRLn0hPWlze7p3NU4w9Ii+LmDGfEQCj6SHl1SBJ/WR8RjSvKiYY5s4gWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954932; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=QubG0PSL3/dw5nrQBOZB5DDX858RzjizrBq1M2TDZjH57hTIqikqxl76nWQGzlZz9rqSpoGcHM6zVMCW8m+TiaW5PEmCiCNjNVKgefHI8oOrCSgR3zbHN+BAopZVYJmEvVl9ObauHLKQqSc79xi+Gu/f2JP6y6I9caa9Fd5vLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=mfOrn9Q2; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="mfOrn9Q2"
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id A082D20B9B; Tue, 10 Sep 2024 09:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1725954922;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=mfOrn9Q2f9ynN+nswiJdoSJpNkhPmZpC/9ZOrWC5ZLd4Tb2ezzx+MR35jK/akKjJX
	 +6izfNnFfnBN72PsXIQI0a9JJ9BN5g+RXBwN4wr5JiBCFikLSNd+0dJt5wbqPsU2R5
	 HzAANAvIGVAEOeAAtcR4Z+DcO/H4jEZRcGjWBEDLNkZ0/ZbinCp7msYAhHsv8iGkVp
	 PFe4O8d23pl6CFR3zoXcTngKGzD7yhDKQukhnZ9JlsFGTKd2pynm7K3fssa9pg3N2C
	 D1EiQXWKOse837UsLB2B5sZgonqkE/yYytOmBiu1SmHbHan6g7W8XrM9ijuSlf3uEq
	 HUdlv7m8hkB8A==
Received: by mail.tradeharmony.pl for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 07:55:08 GMT
Message-ID: <20240910084500-0.1.8k.2zuvm.0.6p7hqlr2kh@tradeharmony.pl>
Date: Tue, 10 Sep 2024 07:55:08 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <mptcp@lists.linux.dev>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun
