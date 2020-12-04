Content-Type: multipart/mixed; boundary="===============4971876329224902248=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: pm: simplify
 select_local_address()
Date: Fri, 04 Dec 2020 17:54:07 +0100
Message-ID: <ccedf0a1-5e13-7ec2-a822-096d7a07a052@tessares.net>
In-Reply-To: 41407581af582a6cb0d4e8a5e46c7af7d54b06d3.1607009691.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7052

--===============4971876329224902248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 03/12/2020 16:35, Paolo Abeni wrote:
> There is no need to unconditionally acquire the join list
> lock, we can simply splice the join list into the subflow
> list and traverse only the latter.

Thank you for the patch and the review!

- db246e6ed6b2: mptcp: pm: simplify select_local_address()
   - With Mat's Reviewed-by tag
   - Applied at the top.
- Results: 8f87392aa646..95b2727396d3

Tests + export will be started soon

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4971876329224902248==--
